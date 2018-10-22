From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 22 Oct 2018 09:17:46 +0100
Subject: [cip-dev] Rebased 4.4 kernel branch
Message-ID: <1540196266.4503.16.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Yesterday we discussed how to find the changes in the 4.4-cip branch
relative to 4.4-stable.  To this end, I rebased our changes on v4.4.154
(the last version I merged into the -cip branch).  I pushed the result
to the linux-4.4.y-cip-rebase branch:
<https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git/log/?h=linux-4.4.y-cip-rebase>.
The tree is identical to v4.4.154-cip28 but duplicate commits were
dropped and I squashed together all the version updates together.

I don't think this is something that needs to be maintained, but it can
provide a basis for summarising the changes we have currently.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
