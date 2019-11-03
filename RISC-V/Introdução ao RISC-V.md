[](https://www.markdowntutorial.com/lesson/4/)

# Introdução ao Assembly RISC-V

## Assembly é :

* ### Rápido :

    Com experiência, é possível produzir código mais rápido que seus equivalentes em outras linguagens de alto nível, tirando vantagem de recursos da linguagem e arquitetura.

* ### Compacto :

    Código assembly tende a ser mais leve que de outras linguagens, consequentemente requer menos recursos de armazenamento e processamento; economia que pode chegar de ⅓ a ¼ da memória e tempo de execução, abrindo espaço para execução de outros serviços ou economia de energia.

* ### Liberdade :

    Abstrações de alto nível permitem a criação de código de forma independente do hardware, o que é interessante considerando princípios de compatibilidade entre arquiteturas; entretanto, esse princípio também implica em uma restrição : não se pode tirar o máximo de proveito do hardware utilizado para execução do código.

    Por exemplo, acessos à dispositivos de Entrada/Saída podem ser mediados pelo Sistema Operacional, sendo a rota comumente escolhida pelos códigos gerados de outras linguagens, ou feito diretamente; construir software tendo conhecimento da arquitetura permite tirar melhor proveito dos recursos e funcionalidades disponíveis.

* ### Conhecimento :

    Conhecer linguagens de baixo nível é uma experiência que contribui muito ao entendimento sobre arquitetura de computadores e linguagens de programação no geral, porque clareia a formação das abstrações usadas nas linguagens de alto nível (estruturas de dados e controle por exemplo).

    Convida, sutilmente, à crítica, reflexão e busca por conhecimento sobre ferramentas e práticas, que muitas vezes negligenciamos por classificar como banalidades; considero programar em assembly a melhor demonstração sobre importância de documentação e buscar seguir boas práticas de produção, por emergir perguntas como: Essa é a melhor abordagem ? Meu código é claro o suficiente ? Dá pra fazer melhor ?