From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 10 Apr 2017 11:28:24 +0100
Subject: [cip-dev] Update 2017wk14
Message-ID: <58EB5E48.4070201@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIP friends,

here is the report of those tasks related with Testing and kernel 
maintenance that Don, Ben, Robert, Lachlan and myself has been working 
on the past two weeks (12 and 13):

++ Board At Desk - Single Dev

The B.A.D.-S.D. team were facing the last few tasks before the release 
when upstream updated kernelci. Some of the changes impacted us. I 
decided to include the updates in this coming release despite having 
past Beta milestone in order to match upstream, which will delay our 
release, scheduled for mid April. In any case, we expect to be testing 
the kernel on regular basis by the time we reach Open Source Summit 
Japan. That has not changed.

This is always a challenging situation for any downstream project, when 
you get an important update from upstream in the middle of the release 
process, as we currently are.

The reason I took this decision is that we, as CIP project, will heavily 
depend on upstream to provide support on LAVA and KernelCI to our 
consumers, due to the complexity of the tooling. We will not be able to 
become the default support channel. It is far from being our goal 
either. I believe it is better for CIP to participate in the existing 
support channel upstream has.

Being up to date with them is the only reasonable way to get that 
support for our future users. Since there is no release from our side 
yet, doing this right will help us in our credibility as project from 
the very beginning.

After taken the decision, the following question is, what will we do if 
this situation happens again in the future? And it will.

It would be very unfortunate if this happens again before our release, 
based on our conversations with upstream. In any case, we will provide 
an stable VM, now that have a "download service", as soon as the issues 
related with the recent update are fixed (we are currently fixing what 
we believe it is the last one, #65).

In general, the VM images will work as stable releases while the 
"development VM" will be provided through Vagrant. This way those 
interested in the development of the tooling itself will be able to get 
the latest commits as they are merged, while those only interested in 
using Board At Desk - Single Dev as consumers will always have an 
"stable image" working, independently of what upstream or our team does.

We will inform through this mailing list as soon as the VM gets to the 
state prior to the upstream update. We will re-focus then on the release.

I apologise for the inconveniences. I understand some of you are looking 
forward to use the VM to test the CIP kernel. It was a tough decision to 
make, with a high impact in the short term, but a higher risk for the 
project in the mid term, in my modest opinion.

Issues closed:
* #49 USB passthrough config needs correcting
* #60 Kernel build failure
* #61 Error on running install_frontend.sh
* #57 Missing error checks in provisioning scripts
* #55 fix behaviour of vm with ifup failures
* #64 The KernelCI Backend fails on missing Ansible variable error_email
* #63 the kernelci webserver will no longer display builds that have 
been performed. This is fact is the same issue that #65

Other issues
* #58 ser2net integration script may generate incorrect configuration 
was reopened.

++ Kernel maintenance

Main tasks:
* Kernel security tracker: Ben H. wrote a template and implemented importers
* Kernel feature support: Ben H. collected and began reviewing members' 
configurations
* Ben Hutchings participated in the last TSC bi-weekly call. He answered 
questions at members' phone meeting. Please check the minutes for 
further details: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/tsc-meetings/tsc_mm_apr032017
* Ben H. reviewed changes for Linux 4.4.60

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
