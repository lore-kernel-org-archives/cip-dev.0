From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 31 Mar 2017 15:42:04 +0200
Subject: [cip-dev] Recent bug after updating kernelci
Message-ID: <58DE5CAC.60201@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

those of you who are trying to build BAD-SD VM with Vagrant might have 
noticed that the builds done with kernelci does not appear in the dashboard.

The ticket is here: https://gitlab.com/cip-project/testing/issues/63

Upstream has updated the backend of kernelci and we are looking into how 
this affects our set up.

In the near future we will provide the VM image so, when upstream 
updates key parts of the tooling breaking our VM, you will still be able 
to download and use the image while we adapt to the new changes.

Best Reagrds

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
