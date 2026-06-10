import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

const SUPABASE_URL = Deno.env.get("SB_URL")!
const SUPABASE_SERVICE_KEY = Deno.env.get("SB_SERVICE_KEY")!
const KIWIFY_TOKEN = Deno.env.get("KIWIFY_TOKEN")!

serve(async (req) => {
  const kiwifyToken = req.headers.get("x-kiwify-token") || ""
const urlToken = new URL(req.url).searchParams.get("token") || ""

if (kiwifyToken !== KIWIFY_TOKEN && urlToken !== KIWIFY_TOKEN) {
  return new Response("Unauthorized", { status: 401 })
}

  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY)

  let body: any
  try {
    body = await req.json()
  } catch {
    return new Response("Invalid JSON", { status: 400 })
  }

  const evento = body?.event || body?.webhook_event_type
  const email = body?.Customer?.email || body?.customer?.email
  const nome = body?.Customer?.full_name || body?.customer?.full_name || ""
  const orderId = body?.order_id || body?.OrderId || ""

  if (!email) {
    return new Response("Email not found", { status: 400 })
  }

  // COMPRA APROVADA
  if (evento === "order_approved" || evento === "OrderApproved") {
    const { error } = await supabase
      .from("membros")
      .upsert({
        email: email.toLowerCase(),
        nome,
        status: "ativo",
        produto: "squads",
        kiwify_order_id: orderId,
        atualizado_em: new Date().toISOString()
      }, { onConflict: "email" })

    if (error) {
      console.error("Erro ao criar membro:", error)
      return new Response("DB error", { status: 500 })
    }

    const { error: authError } = await supabase.auth.admin.inviteUserByEmail(email, {
      data: { nome, produto: "squads" },
      redirectTo: "https://lucasvalerio10.github.io/squads/site/aulas.html"
    })

    if (authError && !authError.message.includes("already been registered")) {
      console.error("Erro ao convidar usuário:", authError)
    }

    console.log(`Membro criado/reativado: ${email}`)
    return new Response("OK", { status: 200 })
  }

  // REEMBOLSO
  if (evento === "order_refunded" || evento === "OrderRefunded") {
    const { error } = await supabase
      .from("membros")
      .update({ status: "inativo", atualizado_em: new Date().toISOString() })
      .eq("email", email.toLowerCase())

    if (error) {
      console.error("Erro ao desativar membro:", error)
      return new Response("DB error", { status: 500 })
    }

    console.log(`Membro desativado: ${email}`)
    return new Response("OK", { status: 200 })
  }

  return new Response("Event ignored", { status: 200 })
})
