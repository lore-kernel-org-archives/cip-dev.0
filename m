From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 8 May 2017 15:01:37 +0100
Subject: [cip-dev] Fwd: [Lava-announce] 2017.5 production release
In-Reply-To: <CAC6CAR2auNoO0eGEYzEcaa5E68OMAGnimYspdbLycVvptRyB7w@mail.gmail.com>
References: <CAC6CAR2auNoO0eGEYzEcaa5E68OMAGnimYspdbLycVvptRyB7w@mail.gmail.com>
Message-ID: <59107A41.4080407@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Don and Robert,

please check below the updates from the LAVA team. Since we are about to 
release, we will inspect these updates and their impact in B at D after the 
release.


-------- Forwarded Message --------
Subject: [Lava-announce] 2017.5 production release
Date: Mon, 8 May 2017 14:15:38 +0100
From: Neil Williams <neil.williams@linaro.org>
Reply-To: linaro-validation at lists.linaro.org
To: Lava Announce Mailman List <lava-announce@lists.linaro.org>

jessie-backports
============

New package update required from jessie-backports.

sudo apt -t jessie-backports install python-voluptuous

This package is used to check the submission schema of V2 test jobs.
It is already installed for V2 support but 2017.5 requires an updated
version which already exists in jessie-backports. For a smooth upgrade
ensure this package is upgraded as above before installing 2017.5.

As with previous releases since 2016.12, the 2017.5 release is only
available from the lava repositories:
https://validation.linaro.org/static/docs/v2/installing_on_debian.html#lava-repositories

New device-type templates
===================

2017.5 includes a lot of new device-type templates and a number of V1
device-type configurations. These have been contributed to LAVA, as
part of the support for KernelCI, by community members. Many thanks to
all those who have contributed device-type support for this release.

Action names and effects on timeouts
===========================

2017.5 makes the individual names of actions in the source code
consistent across all classes and deployments. Where previously
power_off was available as an action name which could be specified in
timeouts and protocols, that action name now uses a hyphen instead of
the underscore, power-off. The same change has been made for all
classes across the V2 lava-dispatcher codebase. Future changes will
only be accepted using a hyphen to separate words, not underscores or
other characters.

This change affects V2 jinja2 templates as well as V2 test jobs (if
those jobs override the action timeout or call an action using
protocols.

The full list of changes is below:

lava-server
========

8ec2d6736 Fix jinja2 templates for default string handling
eb39ec0fd Extend bbb template check for ssh_host support.
55a251b87 Fix documentation example test job and remove unused
7769be718 Update docs for change in submit behaviour.
c10bf6197 Add more index items and detail on namespaces
b9686e5b1 Mark V1 XML-RPC functions as deprecated.
a0ac9894b Prevent health check warning when disabled
78f796eee more silencing of unit test logging
064bfabb9 Add a template for frdm-kw41z and delete a duplicate for k64f
a08df108d Silence logging in more unit tests
97dbd95b1 Extend power-off timeout for b2260
0e39966d4 device-types: add Hardkernel meson8b-odroidc1 board
b6151b003 Add support for aliases in device-type management
15589b8d1 Fix some typos in development documentation.
f476a351c device-types: base-uboot: use run bootcmd
6911b8502 Expand notes on reviews
cbbdcfcf4 Expand notes on code analysis around reviews
970e52230 Drop confirmation page on job submit for V2 jobs.
4a5050691 Device commands are allowed to be lists
cc60805db Adjust hikey template to allow target_mac and ip support
9d4878c40 Avoid forcing the date path immediately
68497b557 Remove the character_delay block override for d03
5aeed4aef Tags: fix HTML syntax errors
a0ae8a62d Update doc for adding a pipeline worker.
2f6287e71 Add Raspberry pi devices
69a8f40c4 Add collection of Exynos 4 and 5 devices
e31953519 Add more Tegra124 based devices
b843bfaec Add more r-car generation 3 devices
24d21cdb0 Add a note on https repositories and apt-transport-https package.
c3b852798 Expand notes on portability
c57c9f111 Fix doc to explain unprivileged containers and DUT interaction.
2018f705c Show the requested device tags in the job log page
96999537e Fix Action names (use - instead of _)
f0a272b4b Extend recent job support to requested device type
9040de9ca Add XML-RPC call to obtain job level metadata
a04086dd7 api: add get_recent_jobs_for_device
8bbd298f7 Set the documented flash_cmds_order for hikey
c9b9453d1 Migrate many U-boot devices to v2 configuration
613d17fb5 Tweak the developer workflow to skip devices/
c59cc6c31 Add a unit test for some of the new UBoot support.
e43e244b0 Remove unused imports and unused variables.
e2b3784f4 Fix pep8 error
af3cc6d42 Schema: Allow boolean variables in parameters
4d5861607 Allow is_valid check to operate correctly.
294bb62bd ensure device_type is checked
b8ce5ba49 Add a note on developer branches
11725bc3e doc: fix a small gap about test suites
6280b94d7 Add "sd" for removable media
21a5ecf6e Add "command" action to schema and device template
8db43278a Add schema validation for test/monitor/name in job definition.
0a5b1eaa3 tweak gitignore
e3f003f63 templates: remove duplicated blocks
f1331ef2e Exclude retired devices from Device Health table
790b39b9d master: use yaml.CLoader that is way faster
749a1081c Add notes on load balancing different bootloaders
26b822d67 Add note on how pyudev replaces / with _
cc9e4ea2c Allow to override U-boot bootcmd command
9a007665c Fix 500 when output.yaml is invalid
b3c2d162b Make it easier to spot incomplete test jobs
fe6af63a7 Improve job and device schema validation
4a568e261 Fix directory and file permissions
f33661ae4 env: fix comments about default values
fd6fe12b6 Fix scheduling when putting a device into looping
99b35ba79 Export the full lava-server version
da87efaa6 base-uboot.jinja2: add support for append_dtb and use_xip
babaef51d lava_scheduler_app: api: Add pipeline information to 
get_device_status
abe787872 Add a note on installing lava-dev
2b6ff1dca MASTER_CERT of lava-master should use secret key
d9e7e2c08 add recipients in notifications.yaml
44eb1b75b Move job outputs to sub-dirs based on submit-time
839b3ff19 Create directories with 0o755 by default
9459aae36 lava-master: call job.output_dir to get the path
8c9af4897 Fix description for devices and workers
541478930 Fix health-check tests by testing None and ''
68b33d572 Use job.output_dir whenever possible
d93df5f4f Add a management command to remove old jobs
bfd57121d Move unnecessary constants into base jinja template.

lava-dispatcher
===========

3be27df4 lxc protocol: simplify the tests
a5d9ebad Fix detection of missing ssh_host value in validate
234eef91 Fix calling of protocols after LXC change
477a36b7 tests: make ShellCommand.logger a DummyLogger
62867f49 Use images.validation.linaro.org files for unit tests
1868936c Silence logging in more unit tests
609c783c Fix download action name
b1701978 More tweaks to silence messages from the unit tests
29efa263 Adjust for pep8 checks in jessie
0733f89f Make sure the test_character_delay is used for all
commands in test shell
78d2509f Account for empty environment string.
ea09b19a Take namespace into account when counting test stages
734688c5 Declare namespace of the test suite in results
49a6b92c Drop noisy info log message.
4fd5d4af Drop unused imports and unused variables
678b216c Rework the removable action to allow sd cards
3b42122a Fix bug #2975 after qemu-nfs introduction
7462ea62 Expand LXC support to add devices from all sybsystems
b853865f Fix missing check for u-boot commands parameters
8293693c Replace invalid characters in test_case_id.
a94e0f24 Fix preseed/late_command appending
db03483a Fix Action names (use - instead of _)
9e836e64 Add a Command Action
bbd4ba25 Make the parser stricter about the block names
65b3a563 Allow to pass integers to run_command
b41326bc Raise JobError instead of NotImplementedError
073f3b34 update gitignore
00f5d33f log: limit the length of lines send other zmq
5b2b0746 LAVA-889 Fix handling of multiple test blocks
3bfdcdb6 Add support for use_xip
8df17dd7 Add support for append_dtb
3c110cae Remove unused imports
176a4d49 Add new utility function infrastructure_error_multi_paths
dc008eb5 Export the full version string.
daebfad1 Extend secondary connection fix to support primary
fae0ced5 Move unnecessary constants into base jinja template.
18f745bc device-types: add kirkwood-db-88f6282.conf
815e518d device-types: add at91sam9m10g45ek.conf
6ca0731f device-types: add at91rm9200ek.conf
003b53dc device-types: add at91-sama5d4_xplained.conf
9b2371cf device-types: add armada-3720-db.conf
5a767331 device-types: add armada-xp-gp.conf
8b050938 device-types: add kirkwood-openblocks_a7.conf
f5801d38 device-types: add alpine-v2-evp.conf
19e20276 device-types: add sama5d34ek.conf
49da704f device-types: add armada-385-db-ap.conf
ed7aa6b1 device-types: add armada-370-db.conf
9a104327 device-types: add at91-sama5d2_xplained.conf
ddb34cea device-types: add alpine-db.conf
f7642f58 device-types: add armada-375-db.conf
0d70c7dd device-types: add at91sam9x35ek.conf
a642d451 device-types: add armada-xp-db.conf
2a5ff9e4 device-types: add armada-7040-db.conf
1a439995 device-types: add orion5x-rd88f5182-nas.conf
ad855a62 device-types: add armada-xp-linksys-mamba.conf
58308ca1 device-types: add armada-388-gp.conf
6a2898bf device-types: add armada-370-rd.conf
cd1b4f47 device-types: add armada-398-db.conf
51925fb1 device-types: add sun8i-a83t-allwinner-h8homlet-v2.conf
4976d068 device-types: add sun8i-a33-sinlinx-sina33.conf
681480d5 device-types: add sama5d35ek.conf
db74d60e device-types: add sun5i-r8-chip.conf
40736b95 device-types: add sama5d36ek.conf
433be0a6 device-types: add imx6q-nitrogen6x.conf
ed4c82e6 device-types: add at91sam9x25ek.conf
ce7a488e device-types: add at91sam9261ek.conf
f87cdb49 device-types: add armada-xp-openblocks-ax3-4.conf
634442ca device-types: add armada-388-clearfog.conf


-- 

Neil Williams
=============
neil.williams at linaro.org
http://www.linux.codehelp.co.uk/
_______________________________________________
Lava-announce mailing list
Lava-announce at lists.linaro.org
https://lists.linaro.org/mailman/listinfo/lava-announce

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
