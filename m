From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 11 Jan 2018 16:51:43 +0000
Subject: [cip-dev] [ANNOUNCE] Linux 4.4.15-cip15-rt10
In-Reply-To: <09576c61-f200-2465-b181-76e2d47b08ec@siemens.com>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
	<20180108093350.lxjocaxlvrmjwpav@linutronix.de>
	<94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
	<20180108105621.osnfazlumesxkwv3@linutronix.de>
	<1515531937.12097.1.camel@codethink.co.uk>
	<D5D6254030DBC644B6EE58B333BFBB1E9D97B5AF@ORSMSX101.amr.corp.intel.com>
	<20180110173232.krwpnlfeijdseinv@linutronix.de>
	<09576c61-f200-2465-b181-76e2d47b08ec@siemens.com>
Message-ID: <1515689503.12097.16.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-01-11 at 09:07 +0100, Daniel Wagner wrote:
> Good morning everyone,
> 
> On 01/10/2018 06:32 PM, Sebastian Andrzej Siewior wrote:
[...]
> > Daniel: you have the release currently in a git tree within his "user"
> > namespace and did not upload it to k.o. Do you plan upload it to the
> > stable-rt tree like Julia does and upload it to the "projects/rt/4.4"
> > folder on k.o.? If so we might just add a link to the cip wiki next to
> > 4.4 and be done with it.
> 
> Steven will ask the k.o folks to give me permission to upload to
> projects/rt/4.4. In short nothing should change for 4.4-rt support as
> long Greg is releasing 4.4.
> 
> As for 4.4-cip(-rt), it might make sense to have a project/cip shared
> folder with the 4.4-cip and 4.4-cip-rt tree.
> 
> Ben, what's your stand on this?

No-one's asked for tarballs and patches, so I don't really want to add
that step to the release process.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
