From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 28 Sep 2018 11:13:36 +0100
Subject: [cip-dev] iwg20m now working with b@d health checks
Message-ID: <87tvmarktr.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Thanks to Nguyen Tan Loc who investigated the unreliability of iwg20m in
the B at D LAVA health check
https://gitlab.com/cip-project/cip-testing/testing/issues/186
and suggested manually converting the zImage to a uImage using the
correct address - this also worked for me and I've altered the
device-type so that LAVA doesn't convert the zImage and uses that
directly.

I've created a merge request:
https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/merge_requests/63
and, so far, have had 6 consecutive test successes with that change.
emails are now going to the cip-testing-results list for that board.

Thanks 

Robert
-- 
Robert Marshall, Software Developer                       Codethink Ltd
Telephone: +44 7762 840 414       3rd Floor, Dale House, 35 Dale Street
https://www.codethink.co.uk/         MANCHESTER, M1 2HF. United Kingdom
