From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Tue, 07 Nov 2017 12:09:59 +0000
Subject: [cip-dev] B@D network setup
In-Reply-To: <5A019FE0.9020503@codethink.co.uk> (Agustin Benito Bethencourt's
	message of "Tue, 7 Nov 2017 12:58:24 +0100")
References: <0fa1ed54-2ab2-06fb-edb4-8db76d760d0c@siemens.com>
	<008201d35771$b8d90e30$2a8b2a90$@toshiba.co.jp>
	<efdd1725-f2c0-e3aa-0e6f-871106ad3d2e@siemens.com>
	<5A019FE0.9020503@codethink.co.uk>
Message-ID: <87po8uxpbc.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Agustin/Daniel

Agustin Benito Bethencourt <agustin.benito@codethink.co.uk> writes:

> Hi,
>
> On 07/11/17 09:47, Daniel Wagner wrote:
>> Hi Daniel,
>>
>> On 11/07/2017 03:40 AM, Daniel Sangorrin wrote:
>>>> So my question is, couldn't we add additional network interface, e.g.
>>>> USB Ethernet adapter, and attach the device under test to this
>>>> interface? I don't know if Vagrant is offering such an option. In the
>>>> past I've done this with Qemu.
>>>
>>> If your network is using the MAC address for authentication you could also
>>> put the MAC address of your USB ethernet adapter into the Virtualbox
>>> ethernet interface (adapter 2).
>>
>> Unfortunately, we do have proper security in place :) The device needs
>> to do EAP and I don't think u-boot is able to this.
>>
>> Having a dedicated network interface (maybe attached to a standalone
>> switch) has also the beauty that you have it complete under control what
>> is happening on the test network.
>
> When designing B at D, we assumed the most simple network
> configuration. Since the system is based on a VM, the network set up
> is something that can be adapted. Looking at this assumption now, we
> probably were optimistic. Yes it can be customised, but the complexity
> might be high to expect a user to do it on her own.
>
> Let's see how we can help. Probably the first step is clearly
> documenting the network set up we currently have in B at D pointing at
> the scripts responsible for such configuration. We will take decision
> from that point.
>
> Robert, what is your take on this approach?
>

I think that first step sounds reasonable - all the network config IIRC
happens in the Vagrantfile apart from the suggested workthrough on the
wiki.

Robert
