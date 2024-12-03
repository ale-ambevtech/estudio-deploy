<img src="./readme/cardboard-unfolded.svg" alt="Estúdio de Papelão" style="width: 200px" />

# Estúdio (de papelão) Backend

O **Estúdio de Papelão** é uma aplicação desenvolvida para criar e testar projetos de visão computacional utilizando recursos avançados do OpenCV. O sistema é parte integrante da plataforma Soda Vision, fornecendo recursos de Processamento Digital de Imagens (PDI) e desenvolvimento de modelos personalizados. O nome "de papelão" reflete sua natureza como protótipo rápido e experimental, focado em validação de conceitos.

# Próximos passos

Aqui iremos anotar algumas ideias que percebemos que seriam interessantes para a versão de Produção.  
Estas ideias não serão implementadas na versão "de papelão", mas são importantes para o desenvolvimento do produto final.

## 1. Armazenamento de vídeos

Atualmente, os vídeos são armazenados localmente no servidor. Para uma versão de produção, é importante migrar para um sistema de armazenamento nosso Blob Storage.

Devido ao Frame Sync, precisamos que o vídeo no front e backend sejam o mesmo. E para isso vamos gerar uma identificação única para que tanto backend quanto frontend acessem o mesmo vídeo.

### Verificação do Local Storage

Algo comum de acontecer é o vídeo descarregar do backend mas ainda sim se manter no localstorage do frontend, pois foi desenvolvida uma lógica para manter o vídeo e parâmetros (marca'ões, timeline, configs) mesmo em caso de recarregamento de página.
Então utilizamos o ID (hash único) do vídeo para verificar se o mesmo ainda existe no Backend. Caso não exista, o backend busca no blob storage se o vídeo armazenado tem o mesmo ID e carrega ele novamente.
Caso não exista no blob storage, o usuário será notificado e o vídeo será removido do localstorage do frontend, avisando que o vídeo não existe mais.
