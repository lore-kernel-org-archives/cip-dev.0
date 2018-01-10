From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 10 Jan 2018 18:32:32 +0100
Subject: [cip-dev] [ANNOUNCE] Linux 4.4.15-cip15-rt10
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1E9D97B5AF@ORSMSX101.amr.corp.intel.com>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
	<20180108093350.lxjocaxlvrmjwpav@linutronix.de>
	<94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
	<20180108105621.osnfazlumesxkwv3@linutronix.de>
	<1515531937.12097.1.camel@codethink.co.uk>
	<D5D6254030DBC644B6EE58B333BFBB1E9D97B5AF@ORSMSX101.amr.corp.intel.com>
Message-ID: <20180110173232.krwpnlfeijdseinv@linutronix.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2018-01-09 21:31:34 [+0000], Hindman, Gavin wrote:
> Sorry for the top-post.  Seems like maybe we are causing confusion by regularly announcing CIP releases on rt-users.  Wouldn't anyone interested in CIP already be subscribed to that mailing list and getting announcements that way?   Maybe it just needs a clearer header, if we think it should stay on rt-users?

I think the announcement was just fine. Now I do know what it does and
what will happen after Greg decides to put 4.4 EOL.

A pointer to [0] as part of the announcement might be help full. In the
end I think it should remain on rt-users since Steven won't continue
doing 4.4 stable. So Daniel's 4.4-RT on top of the CIP tree will be the
only source of a maintained 4.4-RT tree.

[0] wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance

> Maybe a "related projects" section should be created at https://wiki.linuxfoundation.org/realtime/preempt_rt_versions ?  

So what do have in mind? Moving v4.4-RT over to the "No longer
maintained PREEMPT_RT versions" section and adding a new one with
"related projects" where we add the 4.4-cip-rt tree?
Daniel: you have the release currently in a git tree within his "user"
namespace and did not upload it to k.o. Do you plan upload it to the
stable-rt tree like Julia does and upload it to the "projects/rt/4.4"
folder on k.o.? If so we might just add a link to the cip wiki next to
4.4 and be done with it.
Other suggestions?

> -gavin

Sebastian
