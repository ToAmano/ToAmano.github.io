



## schedulerの作成

[aiidaのdoc](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/schedulers.html?highlight=scheduler)


[aiidaのtemplate](https://aiida.readthedocs.io/projects/aiida-core/en/latest/_downloads/19e5364c6b6ae8ca56f6d0d10ada0825/scheduler_template.py)

## schedulerに必要な関数

Two classes `TemplateJobResource` and `TemplateScheduler` are required.

Nine functions are required for the plugin, two of which are optional.

`_get_joblist_command`: returns the command to report a full information on existing jobs.

`_get_detailed_job_info_command`:(optional) returns the command to get the detailed information on a job, even after the job has finished.

`_get_submit_script_header`: return the submit script header.

`_get_submit_command`: return the string to submit a given script.

`_parse_joblist_output`: parse the queue output string, as returned by executing the command returned by _get_joblist_command.

`_parse_submit_output`: parse the output of the submit command, as returned by executing the command returned by _get_submit_command.

`_get_kill_command`: return the command to kill the job with specified jobid.

`_parse_kill_output`: parse the output of the kill command.

`parse_output`:(optional) parse the output of the scheduler.


In addition to these methods, the `_job_resource_class` class attribute needs to be set to a subclass JobResource. For schedulers that work like SLURM, Torque and PBS, one can most likely simply reuse the NodeNumberJobResource class, that ships with aiida-core. Schedulers that work like LSF and SGE, may be able to reuse ParEnvJobResource instead. If neither of these work, one can implement a custom subclass, a template for which, the class called TemplateJobResource, is already included in the template file.