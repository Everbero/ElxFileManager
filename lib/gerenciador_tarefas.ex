defmodule GerenciadorDeTarefas do
  # Inicie o supervisor
  {:ok, _} = FileManagerAiTaskSupervisor.start_link()
  # funcao para executar uma tarefa
  def rodar_tarefa(tarefa) do
    case tarefa do
      :chamar_openai ->
        # Chame a tarefa através do supervisor
        FileManagerAiTaskSupervisor.chamar_openai()
      :chamar_bing ->
        FileManagerAiTaskSupervisor.chamar_bing()
      :chamar_articuloso ->
        FileManagerAiTaskSupervisor.chamar_articuloso()
        # qualquer outra coisa que não seja uma tarefa válida
      :chamar_pandoc ->
        FileManagerAiTaskSupervisor.chamar_pandoc()
      _ ->
        IO.puts("Tarefa inválida: #{tarefa}")
    end
  end
end
