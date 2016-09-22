From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Thu, 22 Sep 2016 11:42:55 +0200
Subject: [cip-dev] Maintenance policies and early considerations II
Message-ID: <57E3A79F.1020602@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

a second consideration discussed during the meeting. Feel free to 
provide your opinions or considerations about them.

++ How should the kernel be released?

+++ Binaries or sources

While commercial distributions like RHEL/SLE include a small number of 
supported kernel configurations in binary form, the CIP kernel should be 
primarily released as source, with the configuration controlled by its 
users.

+++ Kernel features

The project needs to decide which architectures, drivers and other 
kernel features are to be supported by the core team and its releases. 
This could be documented purely as human-readable text or in a 
machine-readable form so that the kernel build process can warn when 
building an unsupported configuration.  It may also be sensible to 
specify the supported toolchain versions.


Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
