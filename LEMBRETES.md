- Lembrar de quando for inserir a nova despesa, colocar ela no top;
- Ver alguma forma elegante de deixar o app sem a appbar, talvez com bottom navigation. uma só para a lista de despesas e outra para o gráfico, um ou mais, ver como compartilhar as informações da tela (lembro que teve um vídeo do fluterando que ele explica algo sobre notifier, e usa o singleton pra fazer um theme switcher)

Lembretes:

- Para usar a ListView é mais performático o ListView.builder e o itemBuilder que vai só renderizar elementos da lista quando eles aparecerem na tela. Lembrar que precisa definir um widget pai (um container, sizedbox, flexible, expanded...) com tamanho para a ListView
- Optar pelo SingleChildScrollView quando se sabe o tamanho da lista.

- Para passar propriedades a um stateful widget, passamos pelo construtor, e em suas classe privada de state podemos usar widget.nomeDaProedade (se aplica a funções tbm)
