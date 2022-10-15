# submitに関して



## metadata.options

`metadata.options`で追加の種々の設定を行うことができる．特にスケジューラのオプションの設定は多くの環境で必須と思う．それ以外に便利なのはインプット，アウトプットファイルの名前を変更したり，コードの実行の前後に追加のコマンドを追加する設定だろう．

- account
  str, optional, non_db – Set the account to use in for the queue on the remote computer
- additional_retrieve_list, (list, tuple), optional, non_db – List of relative file paths that should be retrieved in addition to what the plugin specifies.
- append_text, str, optional, non_db – Set the calculation-specific append text, which is going to be appended in the ^ - - - scheduler-job script, just after the code execution
- **custom_scheduler_commands**, str, optional, non_db – Set a (possibly multiline) string with the commands that the user wants to manually set for the scheduler. The difference of this option with respect to the prepend_text is the position in the scheduler submission file where such text is inserted: with this option, the string is inserted before any non-scheduler command
- environment_variables, dict, optional, non_db – Set a dictionary of custom environment variables for this calculation
environment_variables_double_quotes, bool, optional, non_db – If set to True, use double quotes instead of single quotes to escape the environment variables specified in environment_variables.
- import_sys_environment, bool, optional, non_db – If set to true, the submission script will load the system environment variables
- input_filename, str, optional, non_db – Filename to which the input for the code that is to be run is written.
- max_memory_kb, int, optional, non_db – Set the maximum memory (in KiloBytes) to be asked to the scheduler
- max_wallclock_seconds, int, optional, non_db – Set the wallclock in seconds asked to the scheduler
- mpirun_extra_params, (list, tuple), optional, non_db – Set the extra params to pass to the mpirun (or equivalent) command after the one provided in computer.mpirun_command. Example: mpirun -np 8 extra_params[0] extra_params[1] … exec.x
- output_filename, str, optional, non_db – Filename to which the content of stdout of the code that is to be run is written.
- parser_name, str, optional, non_db – Set a string for the output parser. Can be None if no output plugin is available or needed
- prepend_text, str, optional, non_db – Set the calculation-specific prepend text, which is going to be prepended in the - - scheduler-job script, just before the code execution
- priority, str, optional, non_db – Set the priority of the job to be queued
- qos, str, optional, non_db – Set the quality of service to use in for the queue on the remote computer
- queue_name, str, optional, non_db – Set the name of the queue on the remote computer
- rerunnable, bool, optional, non_db – Determines if the calculation can be requeued / rerun.
- resources, dict, required, non_db – Set the dictionary of resources to be used by the scheduler plugin, like the number of nodes, cpus etc. This dictionary is scheduler-plugin dependent. Look at the documentation of the scheduler for more details.
- scheduler_stderr, str, optional, non_db – Filename to which the content of stderr of the scheduler is written.
- scheduler_stdout, str, optional, non_db – Filename to which the content of stdout of the scheduler is written.
- stash, Namespace – Optional directives to stash files after the calculation job has completed.
Namespace Ports
- submit_script_filename, str, optional, non_db – Filename to which the job submission script is written.
withmpi, bool, optional, non_db – Set the calculation to use mpi
- store_provenance, bool, optional, non_db – If set to False provenance will not be stored in the database.

