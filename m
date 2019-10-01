From: pavel@denx.de (Pavel Machek)
Date: Tue, 1 Oct 2019 10:47:49 +0200
Subject: [cip-dev] Xiling MPSOC -- was Re:  CIP IRC weekly meeting today
In-Reply-To: <CAFa_k0gKU3eudKOK-txbprBA4=B+9RnJXs5VX18GXxvr2SqPYg@mail.gmail.com>
References: <HK0PR01MB2979E0408AE1A9C1323DCEFDE2860@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<CAFa_k0gBzv-2bOF_pGbpvZQyQ1ocEu-bsBNT_JsWi12cxrK-Pg@mail.gmail.com>
	<OSBPR01MB24239C49F9038EB86299B8D4A0860@OSBPR01MB2423.jpnprd01.prod.outlook.com>
	<CAFa_k0gKU3eudKOK-txbprBA4=B+9RnJXs5VX18GXxvr2SqPYg@mail.gmail.com>
Message-ID: <20191001084749.GA1630@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> At the CIP kernel meeting, there was the following conversation regarding the Cybertrust proposal.
> (BTW, 'masashi910' is me. )
> 
> [18:43] <pave1> masashi910: We don't need working version at the moment. But if you could mail the patches, or post pointer for them, or at least diffstat... That would help.
> [18:44] <masashi910> pavel: Thanks. Our work is currently being done locally. I will discuss our team how to share the patches with you.
> 
> The current work which contains all CIP kernel files is compiled into a tar ball, and I uploaded the ball under the following repository.
> https://github.com/masashi910/tmp-cip-xilinx-mpsoc/

Thanks, let me take a look.

For the record, way to get the files is

git clone https://github.com/masashi910/tmp-cip-xilinx-mpsoc.git
cd tmp-cip*
cat linux-4.19.56.tar.bz2.00* > linux.tar.bz2
tar xjvf linux.tar.bz2

Unfortunately, git commands can not be used in that repository, since
it points to alternates somewhere.

I diffed that against v4.19.56; which unfortunately produced unclean
diff as it now also includes the -cip changes. I quickly reviewed and
hand-edited the diff.

I notice this includes staging drivers. 

+obj-$(CONFIG_XILINX_APF)       += apf/
+obj-$(CONFIG_XILINX_FCLK)      += fclk/

I believe you should get those reviewed and moved outside of staging
before attempting to backport them.

Otherwise I don't see anything too scary.

     		      	      	  	  	     	     	     Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191001/c0e204ea/attachment.sig>
