From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 5 Jul 2017 09:44:13 +0900
Subject: [cip-dev] B@D on Windows 10
In-Reply-To: <595B6472.3040006@codethink.co.uk>
References: <878tk97v1o.fsf@ctlt579.codethink.co.uk>	<87lgo45yz2.fsf@ctlt579.codethink.co.uk>
	<595B6472.3040006@codethink.co.uk>
Message-ID: <004901d2f527$d2b78d60$7826a820$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Agustin,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Agustin Benito Bethencourt
> Sent: Tuesday, July 04, 2017 6:49 PM
> To: cip dev
> Subject: Re: [cip-dev] B at D on Windows 10
> 
> Hi,
> 
> On 04/07/17 11:32, Robert Marshall wrote:
> > Robert Marshall <robert.marshall@codethink.co.uk> writes:
> >
> >> The B at D development team has been investigating if there are any issues
> >> with the use of the B at D VM on Windows. The ticket
> >> https://gitlab.com/cip-project/cip-testing/testing/issues/106
> >> is being used to collect information and workarounds.
> >>
> >> Briefly the current issues/state is as follows:
> >>
> >> - We are using virtualbox rather than rsync for config.vm.synced_folder
> >> - core.autocrlf=input is needed in the git settings for the scripts to
> >>    run under Debian (and an ssh client either via git or another route)
> >> - We need to look at a substitute for ser2net running on the host in
> >>    order to open a connection from the VM to the BBB
> >> - The VM installs and both the KernelCI webserver and Lava2 run
> >> - Having built a kernel the build does not appear in the KernelCI web
> >>    interface, there's a long delay before it times out
> >> - Health checks can be created but they don't appear to run, the admin
> >>    interface knows about the devices but they don't appear in
> >>    Scheduler->All Devices
> >>
> >> This testing has been carried out directly from the pure Vagrant install
> >> - once this is running the pre-loaded Vagrant box will also be tested.
> >>
> >> Further work is continuing to get B at D fully operational on a Windows 10 host.
> >>
> >
> > To report on the progress since Friday:
> >
> > - KernelCI does not work with Microsoft Edge or Internet Explorer - we
> >    recommend the use of firefox to display kernel build results - where
> >    the KernelCI web interface does work.
> > - The hostname in the VM is different when run from windows a MR
> >    has been created to deal with both versions of this
> > - The QEMU health check now runs on the W10 virtual machine
> > - The BBB health check will run when connecting to a BBB attached to a
> >    debian machine from the Windows VM both with the linaro kernel and a
> >    locally built one
> 
> Can someone confirm the above results, please? Now that Robert is the
> only person working on the testing front, double checking his results by
> other companies/contributors becomes almost imperative.

Unfortunately I don't have a Windows 10 machine to test it. 
But if the proxy problem is fixed has been fixed I can try instralling B at D again 
on my Ubuntu machine.

Thanks,
Daniel


> Thank you Robert, good progress this week.
> 
> As usual, you can also meet us at #cip in freenode.
> 
> > - We are still in progress of creating and testing a local initiramfs
> >    and configuring the FTDI connection correctly
> >
> >
> > Robert
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
> 
> --
> Agustin Benito Bethencourt
> Principal Consultant - FOSS at Codethink
> agustin.benito at codethink.co.uk
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
