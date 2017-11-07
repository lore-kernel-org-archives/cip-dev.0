From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Tue, 07 Nov 2017 14:19:52 +0000
Subject: [cip-dev] B@D network setup
In-Reply-To: <f8f9a13d-9711-5601-1266-5637b1dcb0ec@siemens.com> (Daniel
	Wagner's message of "Tue, 7 Nov 2017 15:13:57 +0100")
References: <0fa1ed54-2ab2-06fb-edb4-8db76d760d0c@siemens.com>
	<008201d35771$b8d90e30$2a8b2a90$@toshiba.co.jp>
	<efdd1725-f2c0-e3aa-0e6f-871106ad3d2e@siemens.com>
	<5A019FE0.9020503@codethink.co.uk>
	<87po8uxpbc.fsf@ctlt579.codethink.co.uk>
	<f8f9a13d-9711-5601-1266-5637b1dcb0ec@siemens.com>
Message-ID: <87lgjixjav.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Daniel Wagner <daniel.wagner@siemens.com> writes:

> On 11/07/2017 01:09 PM, Robert Marshall wrote:
>>> Robert, what is your take on this approach?
>>>
>> 
>> I think that first step sounds reasonable - all the network config IIRC
>> happens in the Vagrantfile apart from the suggested workthrough on the
>> wiki.
>
> When I tried to build my own VM from scratch I failed at the config part
> inside the VM. Though this is a while ago. Maybe I should just retry to
> build the VM, though I would prefer not to do it. I workaround could be
> to asign the VM my USB Ethernet interface... Need to check the docs :)
>

>From my experience with network issues at ELCE I'd be inclined to just
comment out the

  config.vm.network "public_network", use_dhcp_assigned_default_route: true

line. And the VM should build without problems, it only needs that line
for running a test on the beaglebone black

Robert
