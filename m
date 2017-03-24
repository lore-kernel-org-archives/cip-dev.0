From: hidehiro.kawai.ez@hitachi.com (=?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=)
Date: Fri, 24 Mar 2017 03:39:01 +0000
Subject: [cip-dev] Kernel feature support
In-Reply-To: <58C9695D.9090908@codethink.co.uk>
References: <1489070021.2949.73.camel@codethink.co.uk>
	<58C9695D.9090908@codethink.co.uk>
Message-ID: <04EAB7311EE43145B2D3536183D1A84454EA4E9C@GSjpTKYDCembx31.service.hitachi.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Agustin and Ben,

> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Agustin Benito
> On 09/03/17 15:33, Ben Hutchings wrote:
> > We've previously agreed that not all kernel features (drivers,
> > filesystems, network protocols, etc.) can be supported in an SLTS
> > branch.  I'd like to start working out what the supported features
> > should be for the 4.4 branch.
> >
> > Are members able to share their kernel .config files, showing which
> > features are enabled?  Or would you prefer to specify your needs at a
> > slightly higher level?
> 
> Answering this question is important to discard features in 4.4 that are
> not of CIP interest so we can severely reduce the amount of effort that
> we will need to do in terms of fixes analysis, security etc. in the future.
> 
> Please take some time to provide feedback.

I attached a defconfig for one of our products running on 4.4.12.
This config is based on omap2plus_defconfig, and a diff from
omap2plus_defconfig is also attached.

Currently, each config item has not been prioritized yet, and it
may contain non-important items.  Please treat our defconfig
as a reference at this point.

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

-------------- next part --------------
A non-text attachment was scrubbed...
Name: defconfig
Type: application/octet-stream
Size: 12849 bytes
Desc: defconfig
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170324/94ee26b4/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: defconfig.diff
Type: application/octet-stream
Size: 20958 bytes
Desc: defconfig.diff
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170324/94ee26b4/attachment-0003.obj>
