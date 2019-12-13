From: pavel@denx.de (Pavel Machek)
Date: Fri, 13 Dec 2019 12:47:46 +0100
Subject: [cip-dev] Add CONFIG_IGB to
In-Reply-To: <TYAPR01MB22855636F95B0A1706815692B7550@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB22855636F95B0A1706815692B7550@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191213114745.GA31336@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> I've submitted a pull request[0] that sets CONFIG_IGB to 'y' in siemens_ipc227e_defconfig.
> 
> The reason behind this is so that the Kernel will boot/mount the RFS when using a bzImage in our CI setup.
> See [1] for a test run without this option. [2] shows a run with this option.
> 
> Please let me/the Kernel maintainers know if you have any feedback for this.

It seems Ben alerady merged the request. Thanks for the patch!

Best regards,
   	     	     	    		 	    	Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191213/628b9590/attachment.sig>
