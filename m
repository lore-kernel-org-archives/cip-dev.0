Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D00C433EF
	for <webhook@archiver.kernel.org>; Fri,  4 Feb 2022 06:48:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.48])
 by mx.groups.io with SMTP id smtpd.web09.6022.1643957330347599841
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Feb 2022 22:48:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=ZGR1myJG;
 spf=pass (domain: siemens.com, ip: 40.107.6.48,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm0B67WPWKqg1pNSNx1bnwYmdrvrBrRgLMyNkqPAmWok2Jyvq/KugGoc+N/vDbZfuKwFm7vokThS5jyZvOpQaTlw3O6awdsAl9q3OmJw9l3TvY83/YDtpxENxRNLuEhcUVVWT+NXHY0t6/OoCz0hi+nKpNyyV/t1Le/Uszjb/amixKv7wsoBOHx2Z0Z8zgcrIS1RaMvzREyWomBVNLLxKqOCvcUZms+2v2F5vOSnSguCTVMsqOz5wSH/CuDI+s0mCo5Gtx1fi6kED76hxbQf5ZOcNFNIeoNJBeTeeAGlGF9g7A/x/6yB/TNJzWDZDm40K9lxjLkCCY7mJ45sk6AGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBC2DVTRWvfY04qxc4j7Lz3l6MZYyPT+kan6QZEtl4Q=;
 b=edjapLH0VIcmpA0woynImhMn6VzVam658G+RcseNo34iz4blF/0A5Q35qn65aAkj8jg4COtnwVy3aKjqlkCSNc1xKXmNKNXRs+qGBhjrpv/kgJ3Xgxh4Xr1bw2CXf7IMw/RdFiwSHEmXFkI8qlYv5lXnGlZxIq53iwkgB5Hwdaxu8ANraqRanMClaK1s4yglXUzeAqKI4ubeEQD+uFAX1ihhuStnxCVgmJwQcUZCH+Ncb5/H/ZvlQdvpZxUCl+iFBajG7NNyeVjVYKv3pnE5Qe0nRy6TkBnek5JrzEd8on5C412kBqSMwDx/yiDQ+Z0vhJOlupTxKmoJbY7BwuoDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBC2DVTRWvfY04qxc4j7Lz3l6MZYyPT+kan6QZEtl4Q=;
 b=ZGR1myJGCa+Azjk2WnZAyjtKqHG331fKfZFGj8GZuVoORz9E6WAtX9ZwFalDq65nHzM9xjcExmt8Gg1sc65sggrc+PsFzULuFqRt+1xqVj58vQp6C3CVMmdnyzk36YvEQWWRoskL3lj8+5gxJf4VNrfwzzj9nVa93dt+tOf7+fzHJ64wkw+v6pzIUmJb0ULT0A4xx13QVRvjUWbYUM0cYhcYZJWpeXkWW+X8khHbbXVaXplhyzUHnsyR+wcHCnfY71u+LV9LdzDnUwuog4emL2zwvq/4+A7nApRV73PITpnA8RMto6W2YDrGJYa7I9K1iG2q8EhiQCpMXWPodoq4dQ==
Received: from SV0P279CA0023.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::10)
 by AM0PR10MB3651.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 06:48:47 +0000
Received: from HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::2e) by SV0P279CA0023.outlook.office365.com
 (2603:10a6:f10:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 06:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT043.mail.protection.outlook.com (10.152.0.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 06:48:46 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 07:48:46 +0100
Received: from [167.87.72.47] (167.87.72.47) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 07:48:45 +0100
Message-ID: <c5e89aca-caf7-17dc-7a96-94e86cade48c@siemens.com>
Date: Fri, 4 Feb 2022 07:48:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core v2 2/2] README.swupdate.md: add readme file with
 steps to verify swupdate
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
	<akihiro27.suzuki@toshiba.co.jp>
References: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
 <20220201153502.14230-3-Shivanand.Kunijadar@toshiba-tsip.com>
 <f80fdf3d-816f-2497-0bd3-89e5355977fc@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f80fdf3d-816f-2497-0bd3-89e5355977fc@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.72.47]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef71296-8cef-4faa-2066-08d9e7aa6488
X-MS-TrafficTypeDiagnostic: AM0PR10MB3651:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB3651693B7CC3BE4B8B492DA995299@AM0PR10MB3651.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	woU06kMp6a2hqcIuyH0EZoKGxpmAVXK0O7YBHCDO/8z7J0tgvF/Lu/0k+9fOewDQ4Sk4blNSq9V/hBZjXHw4Vu+pg3lfnX2kT12liPHJ0WIXHDFy6odJ/e5KOUSqtc92Ey1IaYdtqll4USfA4RjpRHhEbuiHkfaZo/g2WWDKr2oSNXy3z+tPo+SJuqc8qss1Fzo9L79432fxV/G+QKXtN0SbtAfMN3OEwNPN3nx/cQT3Gr0lyrObJKsrF13hD85/bUm9ka8HWLhYk82H2AW+IUPMDPJLurCsAprp6zBPbTdKmz6KNFnfR8hKFN6jhnzofPo1yOatcqg8Dvh+IB2D+iNHvd2r3YvShD1+iLwkKz4jWW5LIP6KwjgY23e0oCO4dXRImeX1B1u0g3cZRacCCpCPuHWsXhb1xO2koNdasW/ZeWyuEBeupNc94bXr8467nUJIyxlKmqaGOjzp/JZdHD2X/WCiUgqiIoVRrDBN+QZpqTFlstecysHFztqV2xm5UHQjoP9MFKRCmijZ2E2Bfq4lT243sQn+rCSRn1THDWQ/J/t5cH0cF926CvOlMbVbY00x3FqHOfyUpqrCd3eVtYyn1mLKQJDzEYj4SjKjSIzf/2DSCvzG0aMenPp8GWFXMvFGz4MTa8kQbg0pyrufOFQv+oNZT4/vPfuh2jmqBZuKjM+pn9u1zvI/sfXCK/AdDfjADcOtnLIy2gnc/YHioGLXhOmA9r8p7NnIojZbCMiskxu1w+hDV6tGyCUwfPnBfQu4vf92l3kRZFZeaU1aEbcDb1cnqjebI3DPdh3rnfqcq90k+IRkAuFO+Mt83jGyUSbg0NSUCs7JMYEnUUJF9+k05NdU9NNSmi6G3z4MlPs=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(8936002)(8676002)(70206006)(70586007)(83380400001)(316002)(336012)(36860700001)(82310400004)(956004)(53546011)(2616005)(4326008)(16526019)(36756003)(6706004)(110136005)(54906003)(186003)(26005)(47076005)(16576012)(31686004)(966005)(356005)(40460700003)(82960400001)(7636003)(15650500001)(7596003)(5660300002)(2906002)(86362001)(31696002)(508600001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 06:48:46.5797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 aef71296-8cef-4faa-2066-08d9e7aa6488
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3651
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Feb 2022 06:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7573

On 03.02.22 12:57, Gylstorff Quirin wrote:
> Hi,
>=20
> On 2/1/22 16:35, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>
>> Prepare readme file with necessary steps to verify swupdate feature
>> with rollback functionality.
>>
>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com=
>
>> ---
>> =C2=A0 doc/README.swupdate.md | 208 ++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 208 insertions(+)
>> =C2=A0 create mode 100644 doc/README.swupdate.md
>>
>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>> new file mode 100644
>> index 0000000..56bc77c
>> --- /dev/null
>> +++ b/doc/README.swupdate.md
>> @@ -0,0 +1,208 @@
>> +
>> +Clone the isar-cip-core repository
>> +```
>> +host$ git clone
>> https://gitlab.com/cip-project/cip-core/isar-cip-core.git
>> +```
>> +
>> +Install `kas-container` from the [kas
>> project](https://github.com/siemens/kas):
>> +
>> +```
>> +host$ wget
>> https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
>> +host$ chmod a+x kas-container
>> +```
>> +

Please refer to the existing instructions, rather than duplicating them.
Otherwise, we have to patch the kas-container version information in yet
another place.

>> +Build the image for swupdate
>> +
>> +```
>> +host$ ./kas-container --isar build
>> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
>=20
> Would it be better to use ./kas-container menu?

Technically the same, but the above is probably easier to describe here.
But drop the obsolete "--isar".

>=20
>> +```
>> +- save the generated swu
>> build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-a=
md64.swu
>> in a separate folder (ex: tmp)
>> +- modify the image for example add a new version to the image by
>> adding PV=3D2.0.0 to cip-core-image.bb
>> +- rebuild the image using above command and start the new target
>> +```
>> +host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
>> +```

OK, here that explicit building above, not using kas-container menu,
requires this explicit "SWUPDATE_BOOT=3Dy". But not a major issue, also
given that we will add the panic option below, something that is likely
not helpful to expose in the kconfig menu.

>> +
>> +Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp`
>> folder to the running system
>> +
>> +```
>> +root@demo:~# scp
>> <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-image-cip-core-bus=
ter-qemu-amd64.swu
>> .
>> +```
>=20
> According to https://wiki.qemu.org/Documentation/Networking the default
> host ip should be 10.0.2.2.

Indeed, would be one variable less.

>> +
>> +Check which partition is booted, e.g. with lsblk:
>> +
>> +```
>> +root@demo:~# lsblk
>> +NAME=C2=A0=C2=A0 MAJ:MIN RM=C2=A0 SIZE RO TYPE MOUNTPOINT
>> +sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 2G=C2=A0 0 disk
>> +=E2=94=9C=E2=94=80sda1=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0 16.4M=C2=A0 =
0 part
>> +=E2=94=9C=E2=94=80sda2=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 =
32M=C2=A0 0 part
>> +=E2=94=9C=E2=94=80sda3=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 =
32M=C2=A0 0 part
>> +=E2=94=9C=E2=94=80sda4=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0 =
0 part /
>> +=E2=94=94=E2=94=80sda5=C2=A0=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0 =
0 part
>> +```
>> +
>> +Apply swupdate and reboot
>> +```
>> +root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
>> +root@demo:~# reboot
>> +```
>> +Check which partition is booted, e.g. with lsblk and the rootfs
>> should have changed
>> +```
>> +root@demo:~# lsblk
>> +NAME=C2=A0=C2=A0 MAJ:MIN RM=C2=A0 SIZE RO TYPE MOUNTPOINT
>> +sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 2G=C2=A0 0 disk
>> +=E2=94=9C=E2=94=80sda1=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0 16.4M=C2=A0 =
0 part
>> +=E2=94=9C=E2=94=80sda2=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 =
32M=C2=A0 0 part
>> +=E2=94=9C=E2=94=80sda3=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 =
32M=C2=A0 0 part
>> +=E2=94=9C=E2=94=80sda4=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0 =
0 part
>> +=E2=94=94=E2=94=80sda5=C2=A0=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0 =
0 part /
>> +```
>> +
>> +Check bootloader ustate after swupdate
>> +```
>> +root@demo:~# bg_printenv
>> +----------------------------
>> +Config Partition #0 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console=3Dtty0 console=
=3DttyS0,115200 rootwait
>> earlyprintk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw
>> initrd=3Dcip-core-image-cip-core-buster-qemu-amd64-initrd.img
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 (=
OK)
>> +
>> +user variables:
>> +
>> +----------------------------
>> + Config Partition #1 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C:B=
OOT1:vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root=3DPARTUUID=3Dfedcb=
a98-7654-3210-cafe-5e0710000002
>> console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk rw
>> initrd=3Dcip-core-image-cip-core-buster-qemu-amd64-initrd.img
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 (=
TESTING)
>> +```
>> +
>> +if Partition #1 usate is 2 (TESTING) then execute below command to
>> confirm swupdate and the command will set ustate to "OK"
>> +```
>> +root@demo:~# bg_setenv -c
>> +```
>> +
>> +# swupdate rollback example
>> +
>> +Build the image for swupdate with service which causes kernel panic
>> during system boot using below command.
>> +
>> +```
>> +host$ ./kas-container --isar build
>> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-=
panic.yml

Again, no more "--isar".

>>
>> +```
>> +- save the generated swu
>> build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-a=
md64.swu
>> in a separate folder (ex: tmp)
>> +- build the image again without `kernel-panic.yml` recipe using below
>> command
>> +```
>> +host$ ./kas-container --isar build
>> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml

Also here.

>> +```
>> +
>> +Start the target on QEMU
>> +```
>> +host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
>> +```
>> +
>> +Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp`
>> folder to the running system
>> +
>> +```
>> +root@demo:~# scp
>> <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-image-cip-core-bus=
ter-qemu-amd64.swu
>> .
>> +```
>> +
>> +Check which partition is booted, e.g. with lsblk:
>> +
>> +```
>> +root@demo:~# lsblk
>> +NAME=C2=A0=C2=A0 MAJ:MIN RM=C2=A0 SIZE RO TYPE MOUNTPOINT
>> +sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 2G=C2=A0 0 disk
>> +=E2=94=9C=E2=94=80sda1=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0 16.4M=C2=A0 =
0 part
>> +=E2=94=9C=E2=94=80sda2=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 =
32M=C2=A0 0 part
>> +=E2=94=9C=E2=94=80sda3=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 =
32M=C2=A0 0 part
>> +=E2=94=9C=E2=94=80sda4=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0 =
0 part /
>> +=E2=94=94=E2=94=80sda5=C2=A0=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0 =
0 part
>> +```
>> +
>> +Check bootloader ustate before swupdate and should be as below
>> +```
>> +root@demo:~# bg_printenv
>> +----------------------------
>> +Config Partition #0 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console=3Dtty0 console=
=3DttyS0,115200 rootwait
>> earlyprintk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw
>> initrd=3Dcip-core-image-cip-core-buster-qemu-amd64-initrd.img
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 (=
OK)
>> +
>> +user variables:
>> +----------------------------
>> +Config Partition #1 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> C:BOOT1:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console=3Dtty0 console=
=3DttyS0,115200 rootwait
>> earlyprintk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000002 rw
>> initrd=3Dcip-core-image-cip-core-buster-qemu-amd64-initrd.img
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 (=
OK > +```
>> +
>> +Apply swupdate as below
>> +```
>> +root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
>> +```
>> +
>> +check bootloader ustate after swupdate. if the swupdate is successful
>> then **revision number** should increase to **3** and status should be
>> changed to **INSTALLED** for Partition #1.
>> +```
>> +root@demo:~# bg_printenv
>> +----------------------------
>> +Config Partition #0 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console=3Dtty0 console=
=3DttyS0,115200 rootwait
>> earlyprintk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw
>> initrd=3Dcip-core-image-cip-core-buster-qemu-amd64-initrd.img
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 (=
OK)
>> +
>> +user variables:
>> +----------------------------
>> +Config Partition #1 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C:B=
OOT1:vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root=3DPARTUUID=3Dfedcb=
a98-7654-3210-cafe-5e0710000002
>> console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk rw
>> initrd=3Dcip-core-image-cip-core-buster-qemu-amd64-initrd.img
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 (=
INSTALLED)
>> +```
>> +
>> +Execute reboot command
>> +- reboot command should cause kernel panic error.
>> +- watchdog timer should expire and restart the qemu. bootloader
>> should select previous partition to boot.
>> +```
>> +root@demo:~# reboot
>> +```
>> +
>> +Once the system is restarted, check the bootloader ustate
>> +- if update is failed then **revision number** should reduce to **0**
>> and status should change to **FAILED** for Partition #1.
>> +```
>> +root@demo:~# bg_printenv
>> +----------------------------
>> + Config Partition #0 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console=3Dtty0 console=
=3DttyS0,115200 rootwait
>> earlyprintk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw
>> initrd=3Dcip-core-image-cip-corg
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 (=
OK)
>> +
>> +user variables:
>> +----------------------------
>> + Config Partition #1 Values:
>> +in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> +revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> +kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C:B=
OOT1:vmlinuz
>> +kernelargs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root=3DPARTUUID=3Dfedcb=
a98-7654-3210-cafe-5e0710000002
>> console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk rw
>> initrd=3Dcip-core-image-cip-corg
>> +watchdog timeout: 60 seconds
>> +ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 (=
FAILED)
>> +```
>=20
> Quirin
>=20

Thanks,
Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

