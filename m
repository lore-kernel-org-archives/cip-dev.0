From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 31 May 2018 13:54:58 +0100
Subject: [cip-dev] [PATCH 4.4-cip 0/2] watchdog refcount fixes
Message-ID: <20180531125458.gohmb46oplx4iv4x@xylophone.i.decadent.org.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I noticed two stable fixes for the watchdog core that fix bugs
introduced by commits backported to 4.4-cip (but not 4.4-stable).  So
I should apply these fixes unless the backports somehow avoided the
bugs.

I would appreciate if anyone could review (and ideally test) these in
the next few days.

Ben.

Guenter Roeck (2):
  watchdog: Fix potential kref imbalance when opening watchdog
  watchdog: Fix kref imbalance seen if handle_boot_enabled=0

 drivers/watchdog/watchdog_dev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
