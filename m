From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Thu, 22 Sep 2016 14:59:38 +0200
Subject: [cip-dev] Maintenance policies and early considerations IV
Message-ID: <57E3D5BA.2050905@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

at CIP we need to have a clear view of what "Support" means in the 
context of the Super Long Term Support kernel.

++ What kind of support will CIP provide? To whom?

CIP will support its members and their developers, not system 
administrators or end users.  With the current number of members, there 
should not be a need for a 'first line' of support between them and the 
CIP core developers, though that may change if membership grows 
significantly.

Commercial Linux based distributions like RHEL promise that a subset of 
the kernel module API and ABI remains stable within a major release, so 
that many out-of-tree modules can be used without needing to update the 
module source or binaries along with the kernel.  Some IHVs rely on this 
to distribute driver modules in binary form.

CIP should avoid making any such promise because:

* Upstream fixes frequently change the kernel module API and/or ABI and 
backporting them in a way that does not is difficult and risky   - CIP 
users set their own kernel configurations, so there will not be a single 
kernel ABI for IHVs to target anyway

* CIP users are responsible for binary releases of both the kernel and 
out-of-tree modules, so can ensure that they are properly synchronised.

* The criteria for backporting bug fixes will presumably be based on 
'stable-kernel-rules.txt'.  However, In CIP context, it is recommended 
to be more precise than that.

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
