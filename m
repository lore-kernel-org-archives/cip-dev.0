From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Tue, 7 Nov 2017 09:47:58 +0100
Subject: [cip-dev] B@D network setup
In-Reply-To: <008201d35771$b8d90e30$2a8b2a90$@toshiba.co.jp>
References: <0fa1ed54-2ab2-06fb-edb4-8db76d760d0c@siemens.com>
	<008201d35771$b8d90e30$2a8b2a90$@toshiba.co.jp>
Message-ID: <efdd1725-f2c0-e3aa-0e6f-871106ad3d2e@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 11/07/2017 03:40 AM, Daniel Sangorrin wrote:
>> So my question is, couldn't we add additional network interface, e.g.
>> USB Ethernet adapter, and attach the device under test to this
>> interface? I don't know if Vagrant is offering such an option. In the
>> past I've done this with Qemu.
> 
> If your network is using the MAC address for authentication you could also 
> put the MAC address of your USB ethernet adapter into the Virtualbox 
> ethernet interface (adapter 2).

Unfortunately, we do have proper security in place :) The device needs
to do EAP and I don't think u-boot is able to this.

Having a dedicated network interface (maybe attached to a standalone
switch) has also the beauty that you have it complete under control what
is happening on the test network.

Thanks,
Daniel
