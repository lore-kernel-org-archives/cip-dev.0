From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Fri, 7 Jul 2017 11:54:05 +0200
Subject: [cip-dev] Distribution of binaries: support to Renesas board in B@D
Message-ID: <595F5A3D.80802@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

one of the things we need to figure out is how we will distribute the 
kernel including the support for the Renesas board at CIP.

We have three options to provide the kernel with the board support to 
those users that download the B at D box from the CIP site, to test the kernel:
1. Include the binary (kernel + board support) in the box itself.
2. Download the binaries from the CIP download page.
3. Download from a third party site.
4. Users have to build the kernel themselves.

Since we have a very limited amount of reference boards and kernels, we 
would like to see option one as the default one. Option 2 would also 
work fine. The other two are not ideal for the box (might be for 
deployment through Vagrant).

What are the restrictions we need to face in order to distribute the 
Renesas (source) code and binaries?

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
