From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 20 Jun 2017 14:53:53 +0000
Subject: [cip-dev] Backporting to the CIP Kernel
Message-ID: <TY1PR06MB07026D57AD5E2BD2F2BEBFCCB7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

I hope the move went okay.

I plan to start backporting some patches to the CIP Kernel soon, to begin adding support for the Renesas CIP reference platform.

I've had a look at [1] and have a few of queries...

1)
>11. It or an equivalent fix must already exist in Linus' tree (upstream).
Is this rule set in stone? Or can patches that have been accepted into the relevant maintainer's branches be backported?

Positive: We don't have to wait up to 10 weeks for the new merge window before backporting patches
Negative: There is a small chance that the patches will be rebased in the move from linux-next to linux

2)
For submitting patches, I assume you would like them sent to cip-dev?

3)
For patches that add support for a new platform, would you like them submitted in small series, as they were upstreamed? Or in one big pull request once major support for the platform has been added upstream?


[1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance

Kind regards, Chris
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170620/aaff8b6b/attachment.html>
