From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 15 May 2019 12:33:30 +0100
Subject: [cip-dev] MDS and other speculation issues
Message-ID: <1557920010.3952.2.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

As with the earlier speculation vulnerabilities, I don't believe that
MDS should be a particularly severe issue for CIP-based systems.

Nevertheless, I have prepared a backport of the mitigations for MDS
(and some changes to the mitigations for other speculation issues) for 
4.4.  This was included in 4.4.180-rc1, which is out for review now.  I
did not have the chance to test this thoroughly, so review and testing
are needed.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
