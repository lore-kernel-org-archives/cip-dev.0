Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C52CC433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 09:35:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.5562.1657272935735860167
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Jul 2022 02:35:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2689ZEas024623;
 Fri, 8 Jul 2022 18:35:14 +0900
X-Iguazu-Qid: 2wGrB5FoIBTzICZhHI
X-Iguazu-QSIG: v=2; s=0; t=1657272913; q=2wGrB5FoIBTzICZhHI;
 m=dFeV+YFsahG8Ogqta7HLQW3Xs/GfbY01KafKFREdL54=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 2689ZBUL037763
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Jul 2022 18:35:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuKZkH+Zasn32lswtyRu7jBm/KDt99DDlNoU77M+EJP+cmB9ipg0lEzlTV/tP0ExM3vPCE7wjSTUhY858m7ju8tXY70pbjt/PKdg2AjL5JwW8n324fpk+Ztexf2cZJyiZ1Ufj0/NunuuBU1Og/76DqPFM1OGs6+6zfcR+iZ5OmhdaGno0GtJm8NPFBfukWF/NbDMqxkMuNd1R6onHDda6J5iHnC9U43SySOKvHFR7Pp7UM7uUDGnYthDeRSQ1KPQp+AD7df30oF2vrOQnClOibC0Qn9oJGdjsRtDbej+zaVBT4399kwWDWx4effQqQ86Rx1GWbRa1fwb/XxNs6Uy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5VwPMX96pCQvPm4Qkxs9YcsEtyRxiJSXowar50ERZU=;
 b=TzgrpG57MVgC7NiQQZHaDuNtmJjVeYmiG/ydrNtzMu1Ke7TEuAbnPjpuVA2gCOTuBQ4r93KvG6Fle2qAe5y+ihEoX/vtmhIN8yHro2UxPoP3HM4PLhJhPaXKsNAH288tDgQXZBA7UHqjZ02xwF7ORjbSNaoJDnIMkHCOYQn7A5SQyV2fRJ2kibK3IQQuEx8OakcpGhVY0D2dr0yuvAwrhexH7caivTsXNSc9bWCRsY0VSToakpc16ZdnbATAlda21C/0xsKm6xmoHr9Y/KSFqBw5FBJIrQFUC+nSvX20G9m+bXc6XImW2YEPOag0yD/SgZTL47okc7Y3jKTnjUIuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.251-cip77 and v5.10.129-cip12
Thread-Topic: [ANNOUNCE] Release v4.19.251-cip77 and v5.10.129-cip12
Thread-Index: AdiSrOMy+bz/LaUITQu734orKwQx+A==
Date: Fri, 8 Jul 2022 09:35:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942052B1AB894EE796572EDE92829@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3fded52-b7c3-4aeb-91a3-08da60c52597
x-ms-traffictypediagnostic: TYCPR01MB9815:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ich/5QwyfyCqWJrstAET5gTnp2pzq4djLqh/sTYSgpBtBTgdg6Vri/zAx8t13KYOehL6dLDyS1pj3I2Q9vUHKbPHc1l8lFEZsnV2OzliiK9GV+BOIrU7mQy8S5APes18sfXoEXwhWrfwvJWgXSK7wSE02SAiBfe5hWdPuP46zQ/mYnImpjzSPY+Z1sqEQxbFw24g4K3IcSZEzVKGMYzF8Km8qjqZDBDNvgI8LUNJrWK2qBhf7/ZPvGzW0tICwGC8d5v5DSIc8NNqNbfJZqje1dHs2HlnhqdNBWLkURLZNk+GfYpwj2YMYalFxxhL0H4Vf8OLTscokoq7U/HZ2eHpCcB4Ddnq69LDaHTvb0moOt86GsmwIDqWfnbMhSkFQFD4dZI78/RB20pj7Ew0X41Ko48zmMBzP5eMJTQqyY+AmxD9a1UB6V+ce34aolMknS2tGIrTR7sqnjhSCmPEqf4QlB/ycktTBb+tpQJJG2sUKu31rLCcbdxyyGegbxwARF4Uds78vxIbHyDOIxMwzJ19CymaC3M6jNKOf14Xo85ItSIYBrZp+Jw/XSRFKwX/XgACthf/EFXf8jsCL9T/mnVl/CFVLUWVo2JNQ2k8MK3jS0NcnR/SYucGUa8nf67wvrIO4hhb/8FcUWmuCmdspFGG+i1Gy/cvE+HWDAyVFQx6sybFXaInIcgPXgP2F1cS7O220BvvELo71abLu3v5/2e7YKw8+pvfHC42qxovsocJZ2J+lLf6PgKV+FL6c/IawEDVwmAa/WBtbAAc7d0vSR6q4pX6PibkXmT3xiCHS/sUtrmzV71J2lSmdfNrUgUlyefATRjlFqExpu9ecf2qQlNg2pEWgj7+PYz7N+2Jh4pfnnA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(122000001)(38070700005)(83380400001)(316002)(6506007)(4326008)(6916009)(66446008)(55016003)(8676002)(64756008)(76116006)(66476007)(66946007)(66556008)(38100700002)(2906002)(33656002)(41300700001)(71200400001)(186003)(5660300002)(52536014)(86362001)(54906003)(966005)(9686003)(8936002)(26005)(478600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YnBranAvYnN2ZkVyakdzUHdqZVl2RHkxa1RpV0Q1d2pjLysrK05LVEI5?=
 =?iso-2022-jp?B?bmhKYmU4U1Q3aWJwTSt4YVExSEo5Vlc4MFA3SWYyckxnbnQ3eGwvQzVF?=
 =?iso-2022-jp?B?UGtKRk9vN2E1dWU4a3NpdGN1dVcrYktjME04blpHTUVMSDJNQTAvQWNl?=
 =?iso-2022-jp?B?ZThXbUUyN0U5V05jc0dSangwaHpTdGdtdFF0aGxTRDA1T0kvNGF2dVQ4?=
 =?iso-2022-jp?B?UnNtZUdpUUVwL3dRdHFrRWJ1eTRmVnExKy9wSkNpUDF4MjdTMVZGMEVP?=
 =?iso-2022-jp?B?M01EUEFXYnc4MXlsaUxqc0JYaTYvZlVsdURjM0NsR0FVb2hhb2d5L3Zy?=
 =?iso-2022-jp?B?Y1NxV3lXOEhIYVV0NnIwbklVV3MyU2RRVU1rbVZQOEJMSzg1enlMcWl1?=
 =?iso-2022-jp?B?UG93cEs5TjMzU1JybFRRb21UN3JvcEtXMnY3SzhhVmpXSnNyQVRnQjBl?=
 =?iso-2022-jp?B?bjBTdENMYzZ1QUcyZlNhbnZoQUxxK3RNWEp2ZnRoODB2YW1CQ2RoUXZ6?=
 =?iso-2022-jp?B?L1VGRnZ3KzdjUDZjTFVRY3NnT2o3V3p4cU1ja0RDRzlibStoeTFOc0ho?=
 =?iso-2022-jp?B?ZWc0TVcrbXptWW54MWVCUk9lSXptZVlyNHd5MHhZcDA1VU1HTDRKckJJ?=
 =?iso-2022-jp?B?cSs3K1p1OWFQOHBQdU00Q1M5MjRnSE5OU3FZT01McElsd0RzOUdQbmxK?=
 =?iso-2022-jp?B?b0pENVVYaW9QVjUxUktvWUN2Tm9DTlNqZnRmQmRHUGxQMXB6U2lrbGxU?=
 =?iso-2022-jp?B?M3lQZXRtUHBPMWphZ3ZNclY5TllSKzNjaXJlWlVvTkFVTkpwUGJZL1pD?=
 =?iso-2022-jp?B?VVp3cmt4eW1xd0lPaFRBVXllRmFSUUFGTmdKUThTRzlITWhmTzl5Y1Jt?=
 =?iso-2022-jp?B?MUdVbC84V1cvZnNPYUp1dnQ2d3lQOFh5V3hxS3NVVklZWjloWHJMVUpp?=
 =?iso-2022-jp?B?eEJVVEpZM25aYWtFUlptMWE2LzFSMlhaYzZDMmxSRDJWMzNzRnBRdm90?=
 =?iso-2022-jp?B?aTdNOHFzYTI5RFlKSm14eVJQbHdJOTU1empYRlcrdXk0MEs3NUhaSkNY?=
 =?iso-2022-jp?B?UVlWZnk3cGZWQ2cwcUFxWHRkN2JMd2RuZjJ4LzRFVDZKZnlKSEhwNE9K?=
 =?iso-2022-jp?B?ajNpVzZEVmYxeitZb0hBS0NsYWNwbGJvU0JQZGRDNlhrVklaQzFZdzlk?=
 =?iso-2022-jp?B?SnFPRFBVNzZUSS85YVE4djhuc1NpMVdhOVRxdmhLT3l0OEtJMVg3c1V3?=
 =?iso-2022-jp?B?MTZtbTFhVTQxYnY4RGtZbVNQQndJdUExdTZMOUhYbFhMNWNMN0QvekNZ?=
 =?iso-2022-jp?B?bC96d0o4RUdXYlVOS0UvVWhFanlwWmNiN3RpZkgxVkJhWHlQcHk1WHpZ?=
 =?iso-2022-jp?B?dnM0QlJ3cHAzSllVMC9lVU52VFpOM3hBRnhGbFYvY1B6MWttNEc3dHhX?=
 =?iso-2022-jp?B?bUNkOTNFMHhoOVJLTXl3NjhjOXdyWldSVGlFUm5OS2FRei85L0ttTzdW?=
 =?iso-2022-jp?B?WDB0Q0lFdnJ6bTBHS1Q3OUFjNllxemVYcDNFMVg1cDBIbW1adXhKcjlL?=
 =?iso-2022-jp?B?TXAzWlozTjFpeE53UEZhY0dodzF2eUJ5NkhmRUdnc1B5d0dFcDlTbjJu?=
 =?iso-2022-jp?B?TGwxY2VWL3ovRTY4b1lHU1RtN3U3dWwxTGMweVNKMEorWSt3QTZkTVpG?=
 =?iso-2022-jp?B?cER5b2U4dU9DaEtJd0R0cWhucGNFZzZIbkN6NlA5dXI1OUtJV2FzWUZW?=
 =?iso-2022-jp?B?aDFTWENtdWFrNUNJSllZR0N0Rk54TS9NQUlUKzJhaE9wNDdvSjVqYlA5?=
 =?iso-2022-jp?B?b2p5WGRkU1hCbjhZbEdjVDIyTzlJLzBTeUM5OWkxaGt2bitSVUxQYTBi?=
 =?iso-2022-jp?B?ZVdHUi85YjJRSnJxN1VzRWg0OXp3MWZuOEFCeER3ZkNoRUVpaG94K2hH?=
 =?iso-2022-jp?B?UXlpMmxScm5ZV3RHa2N2UzEwbTIzWlVqeXAybGxZdllGekhKbS9TZ0lu?=
 =?iso-2022-jp?B?djQ3NHdOamx6QWxrSjBubjdueW1sUldzOTdldy9rdU1Lb0hPZWVtRTQz?=
 =?iso-2022-jp?B?T1dpSUh6SzJnOERxbHNxdktWVDdVLzAwdXZDSGpXK252Mnk2VnhwUXc3?=
 =?iso-2022-jp?B?MHBnUC83M1M3UGd3U3BpRnYwdjJGSnNBREF2S3BoRTBJMXRTRnRReDZX?=
 =?iso-2022-jp?B?aEF1SVhhcXBMODhpSzJreUU4R1dXeVlhMTFWZTRPdHFlOEZ6MVlDcDBX?=
 =?iso-2022-jp?B?QkQxMXFCSWhIK1NiQWdRN0RJZVRST1dNRHdRRXM2clFZZnlJamx3SXZI?=
 =?iso-2022-jp?B?TXQ0TnZreDFYYVV1ckl6ZTZEUFlkbnhzZHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d3fded52-b7c3-4aeb-91a3-08da60c52597
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 09:35:08.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ciE1lRy/kS4gZMGQDs0AtEeZQiu6zMkthHyTF80ITu9ygoerM/ZJHcQrHr5DN/uvMKMPb4iZL78vM0UxKoTpDZKWuN4vjBNMOdV+XeaCJ7RzlM8/TA7zf8E9m4KL9I6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9815
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 09:35:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8717

Hi all,

CIP kernel team has released Linux kernel v4.19.251-cip77 and v5.10.129-cip=
12.
The linux-4.19.y-cip tree has been updated base version from v4.19.249 to v=
4.19.251,=20
and the linux-5.10.y-cip tree has been updated base version fromv5.10.126 t=
o v5.10.129.

You can get this release via the git tree at:

  v4.19.251-cip77:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      e634159f2620ade28a9251a9bc2cc23b84f527f2
    Fixed CVEs:
    - CVE-2022-33744: Xen Arm guests can cause Dom0 DoS via PV devices
    - CVE-2022-33742: Xen Linux disk/nic frontends data leaks
    - CVE-2022-33741: Xen Linux disk/nic frontends data leaks
    - CVE-2022-33740: Xen Linux disk/nic frontends data leaks
    - CVE-2022-2318: UAF vulnerabilities in rose protocol
    - CVE-2022-26365: Xen Linux disk/nic frontends data leaks
    added commits:
      CIP: Bump version suffix to -cip77 after merge from stable

  v5.10.129-cip12:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      19dd4538e81e4019bc96ac6521af3a4ec93e110c
    Fixed CVEs:
    - CVE-2022-33744: Xen Arm guests can cause Dom0 DoS via PV devices
    - CVE-2022-33743: Xen network backend may cause Linux netfront to use f=
reed SKBs
    - CVE-2022-33742: Xen Linux disk/nic frontends data leaks
    - CVE-2022-33741: Xen Linux disk/nic frontends data leaks
    - CVE-2022-33740: Xen Linux disk/nic frontends data leaks
    - CVE-2022-2318: UAF vulnerabilities in rose protocol
    - CVE-2022-26365: Xen Linux disk/nic frontends data leaks
    added commits:
      CIP: Bump version suffix to -cip12 after merge from stable

Best regards,
   Nobuhiro


