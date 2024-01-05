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
      # outras tarefas entrarão aqui
      # qualquer outra coisa que não seja uma tarefa válida
      _ ->
        IO.puts("Tarefa inválida: #{tarefa}")
    end
  end
end
