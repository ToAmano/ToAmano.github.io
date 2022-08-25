# ジョブスケジューラの細かい設定

ジョブスケジューラでは使うパーティションの設定や時間制限など細かい設定が可能だが，AiiDAでもそれらの情報を指定することができる．[公式の記事2](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/schedulers.html?highlight=slurm#topics-schedulers-job-resources-node)も参照．


<!--[公式の記事1](https://www.aiida.net/wp-content/uploads/aiidadocs/scheduler/index.html) -->

ジョブスケジューラーの設定方法としてはどうやら2種類ある？

1. codeにmetadata.optionとして追加する方法
2. もっと真面目にやる方法？





## slurmの場合

リンク先の[ソースコード](https://aiida.readthedocs.io/projects/aiida-core/en/latest/_modules/aiida/schedulers/datastructures.html)を見ると

```python
 """A template for submitting jobs to a scheduler.

    This contains all required information to create the job header.

    The required fields are: working_directory, job_name, num_machines, num_mpiprocs_per_machine, argv.

    Fields:

      * ``shebang line``: The first line of the submission script
      * ``submit_as_hold``: if set, the job will be in a 'hold' status right
        after the submission
      * ``rerunnable``: if the job is rerunnable (boolean)
      * ``job_environment``: a dictionary with environment variables to set
        before the execution of the code.
      * ``environment_variables_double_quotes``: if set to True, use double quotes
        instead of single quotes to escape the environment variables specified
        in ``environment_variables``.
      * ``working_directory``: the working directory for this job. During
        submission, the transport will first do a 'chdir' to this directory,
        and then possibly set a scheduler parameter, if this is supported
        by the scheduler.
      * ``email``: an email address for sending emails on job events.
      * ``email_on_started``: if True, ask the scheduler to send an email when the
        job starts.
      * ``email_on_terminated``: if True, ask the scheduler to send an email when
        the job ends. This should also send emails on job failure, when
        possible.
      * ``job_name``: the name of this job. The actual name of the job can be
        different from the one specified here, e.g. if there are unsupported
        characters, or the name is too long.
      * ``sched_output_path``: a (relative) file name for the stdout of this job
      * ``sched_error_path``: a (relative) file name for the stdout of this job
      * ``sched_join_files``: if True, write both stdout and stderr on the same
        file (the one specified for stdout)
      * ``queue_name``: the name of the scheduler queue (sometimes also called
        partition), on which the job will be submitted.
      * ``account``: the name of the scheduler account (sometimes also called
        projectid), on which the job will be submitted.
      * ``qos``: the quality of service of the scheduler account,
        on which the job will be submitted.
      * ``job_resource``: a suitable :py:class:`JobResource`
        subclass with information on how many
        nodes and cpus it should use. It must be an instance of the
        ``aiida.schedulers.Scheduler.job_resource_class`` class.
        Use the Scheduler.create_job_resource method to create it.
      * ``num_machines``: how many machines (or nodes) should be used
      * ``num_mpiprocs_per_machine``: how many MPI procs should be used on each
        machine (or node).
      * ``priority``: a priority for this job. Should be in the format accepted
        by the specific scheduler.
      * ``max_memory_kb``: The maximum amount of memory the job is allowed
        to allocate ON EACH NODE, in kilobytes
      * ``max_wallclock_seconds``: The maximum wall clock time that all processes
        of a job are allowed to exist, in seconds
      * ``custom_scheduler_commands``: a string that will be inserted right
        after the last scheduler command, and before any other non-scheduler
        command; useful if some specific flag needs to be added and is not
        supported by the plugin
      * ``prepend_text``: a (possibly multi-line) string to be inserted
        in the scheduler script before the main execution line
      * ``append_text``: a (possibly multi-line) string to be inserted
        in the scheduler script after the main execution line
      * ``import_sys_environment``: import the system environment variables
      * ``codes_info``: a list of aiida.scheduler.datastructures.JobTemplateCodeInfo objects.
        Each contains the information necessary to run a single code. At the
        moment, it can contain:

        * ``cmdline_parameters``: a list of strings with the command line arguments
          of the program to run. This is the main program to be executed.
          NOTE: The first one is the executable name.
          For MPI runs, this will probably be "mpirun" or a similar program;
          this has to be chosen at a upper level.
        * ``stdin_name``: the (relative) file name to be used as stdin for the
          program specified with argv.
        * ``stdout_name``: the (relative) file name to be used as stdout for the
          program specified with argv.
        * ``stderr_name``: the (relative) file name to be used as stderr for the
          program specified with argv.
        * ``join_files``: if True, stderr is redirected on the same file
          specified for stdout.

      * ``codes_run_mode``: sets the run_mode with which the (multiple) codes
        have to be executed. For example, parallel execution::

          mpirun -np 8 a.x &
          mpirun -np 8 b.x &
          wait

        The serial execution would be without the &'s.
        Values are given by aiida.common.datastructures.CodeRunMode.
    """
```



リンク先の[ソースコード](https://aiida.readthedocs.io/projects/aiida-core/en/latest/_modules/aiida/schedulers/plugins/slurm.html)をみると

```bash
        ('%i', 'job_id'),  # job or job step id
        ('%t', 'state_raw'),  # job state in compact form
        ('%r', 'annotation'),  # reason for the job being in its current state
        ('%B', 'executing_host'),  # Executing (batch) host
        ('%u', 'username'),  # username
        ('%D', 'number_nodes'),  # number of nodes allocated
        ('%C', 'number_cpus'),  # number of allocated cores (if already running)
        ('%R', 'allocated_machines'),  # list of allocated nodes when running, otherwise
        # reason within parenthesis
        ('%P', 'partition'),  # partition (queue) of the job
        ('%l', 'time_limit'),  # time limit in days-hours:minutes:seconds
        ('%M', 'time_used'),  # Time used by the job in days-hours:minutes:seconds
        ('%S', 'dispatch_time'),  # actual or expected dispatch time (start time)
        ('%j', 'job_name'),  # job name (title)
        ('%V', 'submission_time')  # This is probably new, it exists in version
        # 14.03.7 and later
```

の指定が可能のようだ．