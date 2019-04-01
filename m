From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 1 Apr 2019 10:40:19 +0000
Subject: [cip-dev] Patch submissions to cip-dev
Message-ID: <TYAPR01MB22857DA4772C8A496A7AD1CBB7550@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

I'm raising an issue that we discussed in the IRC meeting last week.

The cip-dev mailing list is currently used for a number of different CIP projects e.g. linux-4.4.y-cip, linux-4.19.y-cip, CIP Core, the RT branches etc.

To make it clear to the maintainers I think patch submitters should indicate which repository/branch they are targeting.

One way to do this is by adding a tag in the [PATCH] identifier.

For an example of this, please see the recent submissions from Biju[1] and Fabrizio[2] who are using [PATCH 4.19.y].
(FYI, patchwork hides "PATCH").

Does this approach seem like a good idea? Does anyone have an alternative?

We should probably add a note to the Kernel maintenance page [3], which btw needs to be updated with the current maintainers.


[1] https://patchwork.kernel.org/project/cip-dev/list/?submitter=174479
[2] https://patchwork.kernel.org/project/cip-dev/list/?submitter=175811
[3] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance

Kind regards, Chris

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190401/060851c9/attachment.html>
