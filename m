From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Tue, 13 Feb 2018 09:10:01 +0000
Subject: [cip-dev] [EOL for Lava Version 1] Lava Version 2 replacing
	Lava Version 1
In-Reply-To: <CAEss1ELwQZ88j=AmhkuZwfaqFH6BXHqRuLBW2JqHsWrj8J17bQ@mail.gmail.com>
	(Zoran S.'s message of "Mon, 12 Feb 2018 14:00:33 +0100")
References: <CAEss1EKXtC4qGySW8UyJ2b232XLz+Fq5BrYnopv5z2YitOPDeg@mail.gmail.com>
	<87lgg2jkx8.fsf@ctlt579.codethink.co.uk>
	<CAEss1EJ4k51mYF=Tdri8ipQ1m0t1PrQoOu6f6=Hze0TqVc32bQ@mail.gmail.com>
	<876076gpdz.fsf@ctlt579.codethink.co.uk>
	<CAEss1ELwQZ88j=AmhkuZwfaqFH6BXHqRuLBW2JqHsWrj8J17bQ@mail.gmail.com>
Message-ID: <87a7wdcl1y.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Zoran

Zoran S <zoran.stojsavljevic.de@gmail.com> writes:

>> the current version of B at D uses YAML submissions - see the files in the
>> tests subdirectory.
>
> Could you, please, point to me where these test directories are?
>

https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/tree/master/tests

> I did build two vagrant VM machines, one with debian/stratch64, second
> pre-built debian9, which refuses to behave correctly.
>
> In other words, I would like to see if these test directories are also
> in debian/stretch, built from scratch. If yes, I can go from it to
> build/configure the BBB one.
>

And if you're building the VMs using the B at D git repos on the VM they'll
be in /vagrant/tests

> Since I need to reconfigure the Lava environment to use Beagle Bone Black.
>
>> I'm assuming the 'we' refers to your usage of LAVA as B at D doesn't use V1 tests.
>> I'd recommend moving to V2!
>
> If you do it with YAML, this is V2, so this answers it all.
>

Robert
--
I'm now only responding to B at D/CIP issues on 3 days a week - normally
Wednesday-Friday, on other days emails to cip-dev or directly to me are
likely to be seen, but unlikely to be responded to, until a day I'm
attending to B at D.

> Thank you,
> Zoran
> _______
>
> On Fri, Feb 9, 2018 at 4:21 PM, Robert Marshall
> <robert.marshall@codethink.co.uk> wrote:
>> Zoran,
>>
>> Zoran S <zoran.stojsavljevic.de@gmail.com> writes:
>>
>>> Hello Robert,
>>>
>>> You are correct. I am (as I email to the list about V2) finding more
>>> info about the Lava framework.
>>>
>>> The fact is that, since Lava 2017.2 Version 2 is first usable version
>>> along with Version 1. Both versions coexist from Lava 2017.2 till Lava
>>> 2017.9.
>>
>> According to the B at D feature page, 0.9.1 was using 2016.12-1 and that was
>> V2 - the tests were yaml files then.
>>
>>> Lava 2017.9 was the last one to have both versions (and
>>> Version 1 latest and greatest release). From Lava 2017.11 there is
>>> ONLY one version in it: Version 2. Now, every months Linaro releases
>>> new Lava version, and currently they are at 2018.2.
>>>
>>> So, Lava 2017.7 (used for by CIP testing now) is both V1 and V2 compliant.
>>>
>>> There is a significant difference between Version 1 and Version 2,
>>> considering test scripts: V1 uses JSON test job submissions, V2 uses
>>> YAML test job submissions.
>>>
>>
>> the current version of B at D uses YAML submissions - see the files in the
>> tests subdirectory.
>>
>>> So, here I made a mistake. I was under impression that the test script
>>> format did not change, transiting from V1 to V2. Eeeeeeeek. Wrong!
>>>
>>> The call here is: to use Version 1 or Version 2 from now on, that is
>>> the question? And if we continue to use V1, for how long?
>>>
>>
>> I'm assuming the 'we' refers to your usage of LAVA as B at D doesn't use V1 tests.
>> I'd recommend moving to V2!
>>
>> Robert
>>
>>> Thank you,
>>> Zoran
>>> _______
>>>
>>> On Fri, Feb 9, 2018 at 3:29 PM, Robert Marshall
>>> <robert.marshall@codethink.co.uk> wrote:
>>>> Zoran
>>>>
>>>>
>>>> "zoran.stojsavljevic.de" <zoran.stojsavljevic.de@gmail.com> writes:
>>>>
>>>>> Hello Robert,
>>>>>
>>>>> As I am continuing to investigate this issue with the testing
>>>>> framework, apparently Linaro does NOT support anymore Lava V1
>>>>> (decisively), they already switched to Lava V2 (please, see forwarded
>>>>> email from Neil Williams).
>>>>>
>>>>> As my understanding is, they introduced Lava V2 in 2017.11 version. So
>>>>> far, they've deleted all the databases with the Lava V1 test results
>>>>> (I guess, this applies for Linaro environment usage).
>>>>>
>>>> We've been using LAVA v 2 from the start (well at least from the 0.9
>>>> release and maybe earlier). We're still using LAVA 2017-7
>>>>
>>>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevfeaturepage
>>>>
>>>> gives the relevant versions.
>>>>
>>>>> I am forced to switch abruptly to Lava V2, and here is what I assume
>>>>> after 2 day investigation (yesterday and ongoing today) on Lava:
>>>>> [1] The Lava Version 1 (as well as CIP RT kernel) testing scripts did
>>>>> not change at all;
>>>>> [2] The Lava Version 2 setup did change, in the sense that there are
>>>>> some new technologies used (jinja2 U-Boot parsers);
>>>>> [3] The communication architecture between lava-server and lava-worker
>>>>> did change (ZMQ and XML-RPC), but this is hidden beneath/under the
>>>>> hood (does not affect anything on testing level, Linaro claims this
>>>>> way of the communication between Master and Worker is faster)...
>>>>>
>>>>> Seems an easy change to go, but knowing these humongous Python
>>>>> frameworks (YOCTO Project as obvious example), nothing is easy these
>>>>> days.
>>>>>
>>>>> Does anybody work on Lava Version 2 these days? Would be interesting
>>>>> to try the whole CIP testing framework I am trying to bring up with
>>>>> Lava Version 2.
>>>>
>>>> I'm not sure what you mean here as V2 is under active development?
>>>>
>>>>>
>>>>> Any opinions/provisos on this topic?
>>>>>
>>>>> (please, do note that I have changed my email address on CIP mailing
>>>>> list, introducing the third [more convenient] gmail email for others).
>>>>>
>>>>> Thank you,
>>>>> Zoran Stojsavljevic
>>>>>
>>>>> ---------- Forwarded message ----------
>>>>> From: Zoran S <zoran.stojsavljevic.de@gmail.com>
>>>>> Date: Fri, Feb 9, 2018 at 2:01 PM
>>>>> Subject: Re: [Lava-users] [HW target questions] Pointers from Lava
>>>>> test suite to the HW target
>>>>> To: Neil Williams <neil.williams@linaro.org>
>>>>> Cc: Lava Users Mailman list <lava-users@lists.linaro.org>
>>>>>
>>>>>
>>>>> Hello Neil,
>>>>>
>>>>> Please, hold your horses. I am very new to all this, and I need some
>>>>> time to get to the Lava architecture, meaning to get in proper ways.
>>>>> In the sense, I'll try to rephrase the questions, and the working
>>>>> context, since your answers make me more confused than bring the
>>>>> viable solutions... :-(
>>>>>
>>>>> After reading your email, there are the major addendums to this
>>>>> context, so let me rephrase/rework my initial email.
>>>>> _______
>>>>>
>>>>> My aim is to use Lava V2 (since Lava V1 is not supported anymore). Let it be.
>>>>>
>>>>> As I mentioned, I would like to use Beagle Bone Black (BBB) to Lava
>>>>> worker, and from Lava apache to set the proper context for testing BBB
>>>>> HW.
>>>>>
>>>>> But also, for the starters (seems the step in between) I can do QEMU
>>>>> (the problem is I have no idea how to do this outside of YOCTO
>>>>> Project).
>>>>>
>>>>>> What version of LAVA are you running? On Debian Jessie or Debian Stretch?
>>>>>
>>>>> I am running Lava v2017/7. Which supports ONLY V1. On Virtual Machine
>>>>> Debian Stretch (using VBox as VMM).
>>>>>
>>>>> root at stretch:/home/vagrant# uname -a
>>>>> Linux stretch 4.9.0-4-amd64 #1 SMP Debian 4.9.65-3 (2017-12-03) x86_64 GNU/Linux
>>>>> root at stretch:/home/vagrant# dpkg-query -W -f '${version}\n' 'lava-server'
>>>>> 2017.07
>>>>>
>>>>> My problem here is that I can build the newest version of the
>>>>> Hashicorp debian/stretch64 using vagrant:
>>>>> https://app.vagrantup.com/debian/boxes/stretch64
>>>>>
>>>>> But I am NOT able to include the newest Lava into this setup, since
>>>>> apt-get install Lava (and components) is bringing me Lava V1 (even
>>>>> very old version 2016.12-2)???
>>>>>
>>>>> Q1: how I can bring here the newest Lava 2018.01 (only Version 2
>>>>> compliant)? What the apt-get install Lava-2018.01 or similar command
>>>>> (I am Fedora monkey, as considering my host setup. Lava I am
>>>>> bringing/installing into the VM over VBox VMM)?
>>>>>
>>>>> In other words, what is the specific command I need to use in scripts
>>>>> to bring proper Lava 2018.01??? Or any another command?
>>>>> Here is what is now used: sudo DEBIAN_FRONTEND=noninteractive apt-get
>>>>> -y install lava -t stretch-backports
>>>>>
>>>>>> Jinja is V2 - so things are already getting confused. You can use the U-Boot
>>>>>> that comes with the BBB but you will need to account for any changes in
>>>>>> prompts etc. in the device configuration.
>>>>>
>>>>> I already use the newest 2017.11 BBB U-Boot, so anyway I need to tap
>>>>> (and change some strings) into the following files (as of my best
>>>>> understanding):
>>>>> root at stretch:/# find . -name base-uboot.jinja2
>>>>> ./etc/lava-server/dispatcher-config/device-types/base-uboot.jinja2
>>>>> root at stretch:/# find . -name beaglebone-black.jinja2
>>>>> ./etc/lava-server/dispatcher-config/device-types/beaglebone-black.jinja2
>>>>> root at stretch:/# find . -name qemu.jinja2
>>>>> ./etc/lava-server/dispatcher-config/device-types/qemu.jinja2
>>>>> root at stretch:/#
>>>>>
>>>>> Q2: I need here some examples, if they exist. How I can build these
>>>>> scripts, or should I use existing? Or to do something more to hook
>>>>> Lava to ser2net?
>>>>>
>>>>> I already know: interrupt_prompt: {{ interrupt_prompt|default('Hit any
>>>>> key to stop autoboot') }} <<===== String MUST be changed for U-Boot
>>>>> 2017.11!
>>>>>
>>>>> Q3: I see that base-uboot.jinja2 is a base file. Should I include it
>>>>> it other .jinja2 files using:
>>>>>  {% extends 'base-uboot.jinja2' %}
>>>>>
>>>>>> That looks like you have to manage the power control using
>>>>>> a graphical interface and that's not going to work...
>>>>>
>>>>> Let us skip for now this question (I would like to simplify). PDU is
>>>>> for now not of importance. Focusing to make minimalistic approach to
>>>>> work.
>>>>>
>>>>>> That will show up in /dev/serial/by-id/ and that becomes part of the ser2net configuration.
>>>>>
>>>>> The whole ttyUSB0 using ser2net TCP is done already, works like a
>>>>> charm. In VM, as pass-through device.
>>>>>
>>>>> Q4: do I need to use something special here to hook ser2net terminal to Lava?
>>>>>
>>>>> root at stretch:/# cd /dev/serial
>>>>> root at stretch:/dev/serial# ls -al
>>>>> total 0
>>>>> drwxr-xr-x  4 root root   80 Feb  9 11:29 .
>>>>> drwxr-xr-x 19 root root 3140 Feb  9 11:32 ..
>>>>> drwxr-xr-x  2 root root   60 Feb  9 11:29 by-id
>>>>> drwxr-xr-x  2 root root   60 Feb  9 11:29 by-path
>>>>> root at stretch:/dev/serial#
>>>>>
>>>>>> That is all managed by LAVA in the test job submission. TFTP is already configured.
>>>>>
>>>>> in.tftp works like a charm (tftp-ing from VM to U-Boot BBB), as well
>>>>> as dhcpd (dnsmasq, also from VM). So, I have to trust you if you say
>>>>> that I do not need to do anything on that.
>>>>>
>>>>>> Typically, for the BBB, we use the mainline U-Boot that comes from Debian.
>>>>>> https://packages.debian.org/stretch/u-boot-omap
>>>>>
>>>>> In fact, this was not my question (I have latest 2017.11 U-Boot there
>>>>> on mmcblk1 which is /boot partition, works perfectly).
>>>>>
>>>>> Q5: I wanted to know do I need to set up U-Boot scripts in some ways
>>>>> (as /etc/lava-server/dispatcher-config/device-types/beaglebone-black.jinja2
>>>>> suggests, as example)??? In other words, make U-Boot environment more
>>>>> as .jinja2 suggests?
>>>>>
>>>>>> Start with QEMU, make sure that's working and get an understanding
>>>>>> of how that works with the device dictionary, test job submission,
>>>>>> test shell definitions and general LAVA UI usage.
>>>>>
>>>>> Q6: So, what I need to do here? I use YOCTO project to build all BBB
>>>>> embedded Linux ingredients, uImage, .dtb and root tree, how I can use
>>>>> QEMU from YOCTO as independent .exe in Lava context??? Or, maybe,
>>>>> after all, I can try real image?!
>>>>>
>>>>> I apologize for the long email. Some features are already solved
>>>>> (tftp, edhcp, ser2net), so we do not need to include them further (as
>>>>> I now understand).
>>>>>
>>>>> Thank you,
>>>>> Zoran
>>>>> _______
>>>>>
>>>>> On Fri, Feb 9, 2018 at 10:23 AM, Neil Williams <neil.williams@linaro.org> wrote:
>>>>>> On 9 February 2018 at 09:00, Zoran S <zoran.stojsavljevic.de@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Hello to the Lava users,
>>>>>>>
>>>>>>> I am the new Lava user. My aim is to use Lava (for now V1)
>>>>>>
>>>>>>
>>>>>> Welcome. Please take care with terminology. V1 is already dead, please don't
>>>>>> start there. We will be unable to help you with your V1 setup. Your later
>>>>>> comments refer to elements from V2, so please take care with which bits of
>>>>>> documentation you are following.
>>>>>>
>>>>>> What version of LAVA are you running? On Debian Jessie or Debian Stretch?
>>>>>>
>>>>>>>
>>>>>>> setup for my testing, from the beginning just to hook-up my Beagle Bone
>>>>>>> Black (BBB) to Lava worker, and from Lava apache to set the proper context
>>>>>>> for testing BBB HW.
>>>>>>>
>>>>>>> As I am reading Lava framework, I got the following impression about the
>>>>>>> test suite:
>>>>>>> [1] I need to prepare BBB's U-Boot for the Lava U-Boot jinja2 setup;
>>>>>>
>>>>>>
>>>>>> Jinja is V2 - so things are already getting confused. You can use the U-Boot
>>>>>> that comes with the BBB but you will need to account for any changes in
>>>>>> prompts etc. in the device configuration.
>>>>>>
>>>>>>>
>>>>>>> [2] I need to hook-up my EG-PMS2-LAN (energenie) to the Lava (to PO and
>>>>>>> POFF HW platform);
>>>>>>
>>>>>>
>>>>>> That looks like you have to manage the power control using a graphical
>>>>>> interface and that's not going to work. You'll need to investigate how to
>>>>>> control that unit using the command line only. Does it have a telnet API or
>>>>>> other serial API? That will all be down to you to configure. You might want
>>>>>> to look at using an APC PDU instead as those already have support in lavapdu
>>>>>> (or can use SNMP if you configure the worker appropriately).
>>>>>>
>>>>>> [3] I need to hook-up ser2net interface (which I already have working over
>>>>>> TCP) to the Lava. so Lava can control it;
>>>>>>
>>>>>> That goes into the device dictionary, as per the docs. Do you have the FTDI
>>>>>> cable to attach to the BBB to get the serial connection? That will show up
>>>>>> in /dev/serial/by-id/ and that becomes part of the ser2net configuration.
>>>>>>
>>>>>>>
>>>>>>> [4] I need to hook-up uImage, .dtb and ramdisk images to the Lava (which
>>>>>>> will be FTPed and set in memory for board setup and testing).
>>>>>>
>>>>>>
>>>>>> TFTP, not FTP.
>>>>>>
>>>>>> That is all managed by LAVA in the test job submission. TFTP is already
>>>>>> configured.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Question 1: Does manual have some Beagle Bone Black U-Boot default
>>>>>>> scripts, which should be provisioned to the BBB U-Boot for the correct Lava
>>>>>>> U-Boot behavior?
>>>>>>
>>>>>>
>>>>>> Typically, for the BBB, we use the mainline U-Boot that comes from Debian.
>>>>>> https://packages.debian.org/stretch/u-boot-omap
>>>>>>
>>>>>>>
>>>>>>> Question 2: How do I do [1], [2], [3] and [4], does Lava manual have some
>>>>>>> explanation as working example how to do these points?
>>>>>>
>>>>>>
>>>>>> Those are mostly specific to your local setup.
>>>>>>
>>>>>>>
>>>>>>> Question 3: Anything else I missed for the proper Lava test setting?
>>>>>>
>>>>>>
>>>>>> Start with QEMU, make sure that's working and get an understanding of how
>>>>>> that works with the device dictionary, test job submission, test shell
>>>>>> definitions and general LAVA UI usage.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thank you in advance,
>>>>>>> Zoran
>>>>>>>
>>>>> _____________________________________________
>>>>>>> Lava-users mailing list
>>>>>>> Lava-users at lists.linaro.org
>>>>>>> https://lists.linaro.org/mailman/listinfo/lava-users
>>>>>>>
>>>>>>
>>>>>> Neil Williams
>>>>>> =============
>>>>>> neil.williams at linaro.org
>>>>>> http://www.linux.codehelp.co.uk/
>>>> _______________________________________________
>>>> cip-dev mailing list
>>>> cip-dev at lists.cip-project.org
>>>> https://lists.cip-project.org/mailman/listinfo/cip-dev
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
