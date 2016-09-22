From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Thu, 22 Sep 2016 11:31:32 +0200
Subject: [cip-dev] Maintenance policies and early considerations I
Message-ID: <57E3A4F4.6050109@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

during the Technical Committee Meeting, last Monday, Ben Hutchings 
brought to the attention of the participants several topics to consider. 
I would like to bring them here. This is the first one

++ When do CIP should pick up a kernel?

+++ Maintainability effort

New major versions of commercial Linux Distributions are released at 3-4 
year intervals, so that typically only 4 versions need to be supported 
at one time.  Given that CIP's support period is meant to be even 
longer, it won?t be sustainable to extend every 'long term' branch, but 
only takes on a new branch every 2-4 years.

+++ Backport effort

The longer the intervals between new CIP branches, the greater need 
there will be for CIP or individual members to backport new hardware 
support (which carries its own risks).

+++ Trade-off

This trade-off is perhaps the most difficult issue to decide.


Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
