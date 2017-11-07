From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Tue, 07 Nov 2017 10:54:22 +0000
Subject: [cip-dev] B@D network setup
In-Reply-To: <efdd1725-f2c0-e3aa-0e6f-871106ad3d2e@siemens.com> (Daniel
	Wagner's message of "Tue, 7 Nov 2017 09:47:58 +0100")
References: <0fa1ed54-2ab2-06fb-edb4-8db76d760d0c@siemens.com>
	<008201d35771$b8d90e30$2a8b2a90$@toshiba.co.jp>
	<efdd1725-f2c0-e3aa-0e6f-871106ad3d2e@siemens.com>
Message-ID: <87y3nixstd.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Daniel,

Daniel Wagner <daniel.wagner@siemens.com> writes:

> Hi Daniel,
>
> On 11/07/2017 03:40 AM, Daniel Sangorrin wrote:
>>> So my question is, couldn't we add additional network interface, e.g.
>>> USB Ethernet adapter, and attach the device under test to this
>>> interface? I don't know if Vagrant is offering such an option. In the
>>> past I've done this with Qemu.
>> 
>> If your network is using the MAC address for authentication you could also 
>> put the MAC address of your USB ethernet adapter into the Virtualbox 
>> ethernet interface (adapter 2).
>
> Unfortunately, we do have proper security in place :) The device needs
> to do EAP and I don't think u-boot is able to this.
>
> Having a dedicated network interface (maybe attached to a standalone
> switch) has also the beauty that you have it complete under control what
> is happening on the test network.
>

We've opened a ticket for this
https://gitlab.com/cip-project/cip-testing/testing/issues/169 

so that we can investigate and you can keep track!

Robert
