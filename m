From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 07 Jul 2017 11:47:26 +0100
Subject: [cip-dev] B@D on Windows 10
In-Reply-To: <87lgo45yz2.fsf@ctlt579.codethink.co.uk> (Robert Marshall's
	message of "Tue, 04 Jul 2017 10:32:33 +0100")
References: <878tk97v1o.fsf@ctlt579.codethink.co.uk>
	<87lgo45yz2.fsf@ctlt579.codethink.co.uk>
Message-ID: <87mv8g5xs1.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall <robert.marshall@codethink.co.uk> writes:

> Robert Marshall <robert.marshall@codethink.co.uk> writes:
>
>> The B at D development team has been investigating if there are any issues
>> with the use of the B at D VM on Windows. The ticket
>> https://gitlab.com/cip-project/cip-testing/testing/issues/106
>> is being used to collect information and workarounds.
>>
>> Briefly the current issues/state is as follows:
>>
>> - We are using virtualbox rather than rsync for config.vm.synced_folder
>> - core.autocrlf=input is needed in the git settings for the scripts to
>>   run under Debian (and an ssh client either via git or another route)
>> - We need to look at a substitute for ser2net running on the host in
>>   order to open a connection from the VM to the BBB
>> - The VM installs and both the KernelCI webserver and Lava2 run
>> - Having built a kernel the build does not appear in the KernelCI web
>>   interface, there's a long delay before it times out
>> - Health checks can be created but they don't appear to run, the admin
>>   interface knows about the devices but they don't appear in
>>   Scheduler->All Devices
>>
>> This testing has been carried out directly from the pure Vagrant install
>> - once this is running the pre-loaded Vagrant box will also be tested.
>>
>> Further work is continuing to get B at D fully operational on a Windows 10 host.
>>
>
> To report on the progress since Friday:
>
> - KernelCI does not work with Microsoft Edge or Internet Explorer - we
>   recommend the use of firefox to display kernel build results - where
>   the KernelCI web interface does work.
> - The hostname in the VM is different when run from windows a MR
>   has been created to deal with both versions of this
> - The QEMU health check now runs on the W10 virtual machine
> - The BBB health check will run when connecting to a BBB attached to a
>   debian machine from the Windows VM both with the linaro kernel and a
>   locally built one
> - We are still in progress of creating and testing a local initiramfs
>   and configuring the FTDI connection correctly
>   

A further update on progress on this issue:

 We've configured the Windows 10 virtual machine with ser2net (running
 on the vm and enabling usb in the Vagrantfile) and now the beaglebone
 black health check runs - and has been used to health check the new
 v4.4.75-cip6 (together with a locally built initramfs).

 I've exported a box from the W10 VM and successfully reimported it and
 run a HC. We're still having problems with boxes exported from Debian
 which give an error that port 8888 is in use or it attempts to
 re-provision the box.

Robert
