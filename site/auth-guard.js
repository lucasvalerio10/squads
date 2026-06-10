// auth-guard.js — proteção de páginas da área do cliente
const SUPABASE_URL = 'https://vvzeczcfreebqtuhahyg.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ2emVjemNmcmVlYnF0dWhhaHlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEwNDM0NzEsImV4cCI6MjA5NjYxOTQ3MX0.ZF1B6yl27Kxi8_vZJ6yloVJozNPo06ttSbVafcOsH_Y'

async function verificarAcesso() {
  const { createClient } = supabase
  const sb = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

  // Processar magic link se vier da URL
  const { data: { session }, error } = await sb.auth.getSession()

  if (!session) {
    // Sem sessão — redireciona pro login
    window.location.href = 'login.html'
    return
  }

  // Verificar se membro está ativo na tabela
  const { data: membro } = await sb
    .from('membros')
    .select('status')
    .eq('email', session.user.email)
    .single()

  if (!membro || membro.status !== 'ativo') {
    await sb.auth.signOut()
    window.location.href = 'login.html?erro=acesso'
    return
  }

  // Acesso liberado — mostrar conteúdo
  document.body.style.visibility = 'visible'

  // Adicionar botão de sair no nav
  const nav = document.querySelector('nav')
  if (nav) {
    const btnSair = document.createElement('button')
    btnSair.textContent = 'Sair'
    btnSair.className = 'btn btn-outline'
    btnSair.style.fontSize = '13px'
    btnSair.onclick = async () => {
      await sb.auth.signOut()
      window.location.href = 'login.html'
    }
    nav.appendChild(btnSair)
  }
}

verificarAcesso()
