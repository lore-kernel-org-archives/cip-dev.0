Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2477BC02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:22:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.11715.1738761767417406379
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Feb 2025 05:22:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 515DMiTI531963; Wed, 5 Feb 2025 22:22:45 +0900
X-Iguazu-Qid: 2rWhEqwpifmAcDsPJZ
X-Iguazu-QSIG: v=2; s=0; t=1738761764; q=2rWhEqwpifmAcDsPJZ; m=+yJBIhFNbpqu4GzoLAcLv6osv6Yp5kTc59qvKGIPkvo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 515DMhPA4115579
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 22:22:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZPnkfuIlR3HfqM5NyfWREPuNRVpz6cjiuOSYG4N/fdbE20Dbxzryd1guGgA4BoWwyPllcN2YipnLIsol/g+QvxyZ4znHFIKVZ28skVhmtrXvL8tTYdxu2yI+mjm6jg6F8jzezcc7SEGYuZZgkNbf2vS0abZpLdTNZ6SIEWci2RIuQm0uBSrhcRfRk/UVzkfk2IytYr/IHJ8G2nHfrkl+IVBcgGuz2Qwth4ttFOygf2l+bMBp5Rg+rR1Lz+YPJfO+pOVXkOhThx/0d8xTublKtB9Ji0DhaGP4ij8X/s7laCUlEOxHFFnwSaxy8FeSgJdUzw0EZvdkJOS2IMAo0SeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kDstGXVQ13U/ud9RszimhFyDeCSSbQaX/FUfvsqr0M=;
 b=IuAz88K8oVthMUrDxMVxC6wocQNikafcONx7gMcba9CXdlfksM91/yQYpbXPjwOwl/A969BV7i3Ybqbx6PJeQ4lscdfb7puIKXVwaHezx2prZbzDzeXxU/k5hvYw3a4ZafKyayPMb3QHjP9GahQDNK0GXZYiTYgKkYuvKeIiE3ZLeEaf/3E35CQFl2JEaWMAdEOwCI5xKs7VuiugINUVi16O1vQAkteH5reUzdKmiS7grtN21P8mgvT1/B105CkAZZpvmkRDTXze1dJDf4NjOvnt6Bkl9n9hIFAalPKZw14rhaTX48LDJemIms3omxMrG/63oVxO2iQFQvx23JJlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file as
 template to make installation path configurable
Thread-Topic: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file as
 template to make installation path configurable
Thread-Index: AQHbdjKwedw02Qj0V0OVnTdmNNMZ6bM3IucAgAGLah8=
Date: Wed, 5 Feb 2025 13:22:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6100B7D4C183871F0E47D056C2F72@OS0PR01MB6100.jpnprd01.prod.outlook.com>
References: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250203115321.3589084-3-Sai.Sathujoda@toshiba-tsip.com>
 <578c7f2c-ef52-492f-9dc8-054d6bed958b@siemens.com>
In-Reply-To: <578c7f2c-ef52-492f-9dc8-054d6bed958b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS7PR01MB11778:EE_
x-ms-office365-filtering-correlation-id: 9de37fa7-022c-4793-96d1-08dd45e82996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TzVBc2pxNjZGcTRhNTRoS2pnOUl2eE1uSjh5RXVHNmh1MzQ1dldQNUJp?=
 =?iso-2022-jp?B?Z0ZreTR3eDEwSERtRkw2bzN0bFlZSEI2WWZscVZXQUN0eTErRHJvaW1v?=
 =?iso-2022-jp?B?UjN6Q1o5NFVsZWF1bW5HbG40Um5oQmhabUVYUDdoYlFqVDk1RGYvMzl3?=
 =?iso-2022-jp?B?b3Q4eldIbll2ZVp3Zmwyb0YrYUFtWmNneG14ZGVQMnQ2UzdCc3VDdEhl?=
 =?iso-2022-jp?B?Qi9RcWFhUG9MUXcvN2c4WTRONEEyTGZ1Yzgyb2xGVmlISllrbTZmSkk3?=
 =?iso-2022-jp?B?MnhOYytCU2l3NjZ1NEdmcXdqZG5BQVdtdS9VeFZGNWN2dGlWYXRqL2hT?=
 =?iso-2022-jp?B?U0J0VEx4K0RUTFk1ZGJKMUIvNHhkSnNycVZINFl4V2wxakpuZnFNMkVO?=
 =?iso-2022-jp?B?Wk1XRDA1cFA0emovK3YySks3SXFYbXc0MWc2a3B5dDNIU3Z2YkxBT2py?=
 =?iso-2022-jp?B?NEt6NjZJMWpGRm5MVHovdGpsbWNaZ3prN0JPUlIramxKYVNzZEk3V0Zj?=
 =?iso-2022-jp?B?OGM3ZW0veXpReHhGWXQ3WVl3REdpY0RZQkZ2UUQ0QytneTh3eXdTa2Mz?=
 =?iso-2022-jp?B?YWZ1NGh0eFVLQkRqOTNVNGYyNjc3VlFYN1RvTXFhWllUL2x0VWVETThj?=
 =?iso-2022-jp?B?YjdEVWZaTzBaa3o4UmQ2dVVveEZQNWRNZmcrejhQbjNIWXdTSzVSUEVB?=
 =?iso-2022-jp?B?MWRaNUVScjV4aHIwQ2p2S1RHU3JaTVRLcm8rU2VtRlV4c2xnNituODNk?=
 =?iso-2022-jp?B?bVZGL0RKVDZOcktqa2lVRzBFSy9LSXZjSDVoOHdHYXJURGFrSEYwRXRa?=
 =?iso-2022-jp?B?OWRPUlRIWGtEZEhQYmhrczd2S05aMWVyM01WeDBNWG9xZFcwTU9YZHov?=
 =?iso-2022-jp?B?eWpLQWdvb2F5c1lWSFQ4cCs3dS9Ec2YxZGhPUTgwMi92eVY3RmpMME5H?=
 =?iso-2022-jp?B?MmdEWjVBOXlhYXVKYU9WMkJhTXRDbTVrY2RMY0ZDZk1BanNoSXdvSWtV?=
 =?iso-2022-jp?B?NkhzQk1rck43VmZRb1FVV0tNWlJ5WFpLK0RsUTBHYlJLTGhmU0NRUUZ0?=
 =?iso-2022-jp?B?a2NWSXZVYzlrcjc4clFSS3plYklITkFzQmVCWVBOaTF4N1dRV293MjR5?=
 =?iso-2022-jp?B?WmFLcEJKaUYxS0ZHa0dETlQ0Q24vL1NmVGZneHUvK0VkaktxVVl4S1gv?=
 =?iso-2022-jp?B?OU1tdE1odjcrMXNUYzRJb21wRmp3SlJPV2p4aVp2Tko1S0pOSnE5V0lh?=
 =?iso-2022-jp?B?d044bGVXVTdhaFM1cGhmUlNJTWpPb2czRUJaZHNMT1ZVc1dNRkFDUWY3?=
 =?iso-2022-jp?B?MTZqbktqTjB1V3VhVzhrM3d5LzhPVjJmUnZrMXF2Tks0czhobXZCSHMw?=
 =?iso-2022-jp?B?SHl2Y0lnSCtOS0xUeVZXR0dzVThQVlNOUkFzRnB4YmpHcGw3RTJDRWo5?=
 =?iso-2022-jp?B?UEZEN2QyR0VhY0YxSDhjYWpLWHA4T0ZSOUx6OU0xcWUrUGZhTnBQa1B5?=
 =?iso-2022-jp?B?TzdGUVZ2MmtWM0p0WmJjQUVIV09yYlhrU1dhM1RVNVdFbTZ6SXQxZDlU?=
 =?iso-2022-jp?B?NFdjYmx5ODVodGdDeFZNZ3Z2OVBpczVpbUhiQ1BQeWhiK2lwN25VN2hW?=
 =?iso-2022-jp?B?YUZjQU5ZL0YzTGI0MEZUMGVnY3V0Nm83SjVuVTFIY2g5UllTVzRYcGlo?=
 =?iso-2022-jp?B?NVNoY3lMUFNId3dkZzhXcExkZ0xqTkVsMk9WWXNkdDRWSVVzeUwwMEMx?=
 =?iso-2022-jp?B?RlZnN1UvWkdtenhXWGFDU094V1UwWVR4RjcwSlhaRC9mQ0hPWENOSkxP?=
 =?iso-2022-jp?B?c1Y1UTAwNUVuWWF1d1JMU3lGRkFDMTExS21ab1BGL3FsNVhmdXdSejRr?=
 =?iso-2022-jp?B?dTRtMmpkOG11VjdFMS9WdW1LNTlxekxMSEo4QzZiK0xEUFF4bjVwR0dD?=
 =?iso-2022-jp?B?WXJJN0o2R1c0d3RTL200YUowUXRuMmVwYkxsenJBcy9vL1g1am05enc4?=
 =?iso-2022-jp?B?bmM1SUd1RnJDNEtJY0N1emY5OVdlU3A0c0oxSlV5L2JJY3BBQVNHSlNy?=
 =?iso-2022-jp?B?ZnM4bnluZ3ZTZ0c0SXZaM1ZHbkIzSnIrRmhjUUZuNnF4cTMyN3g2Wk1n?=
 =?iso-2022-jp?B?Sm8=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cGlsR1VGNExoTTczaTlTZ0MrZDM3ZEZPUHZ0M0llTlRuNXQrQ3kwMEdx?=
 =?iso-2022-jp?B?WDU1VDVuT2wyeHNTbUx0Q2c4RUNCT2xaSURoMWh5aHBLd2puSjRzck1n?=
 =?iso-2022-jp?B?WWlhUURNSS91aHRsTlNLRmZQUmpkTlhFWC92cis2Z0I4TVZvUGhTWkxE?=
 =?iso-2022-jp?B?bjVCTm13bTFtWCtRQmVRRmZQUGxmWmlJeDNnc0JQRHQyRUZhYTVGUElH?=
 =?iso-2022-jp?B?RzlTV3Zqc2dWUFE2Q2sxWTl1SlZ2a3NwaG5lTkZpWThHZDhBVGxMbmoy?=
 =?iso-2022-jp?B?VUhkeDdpZzR2QnV1cGNLcDRmcktPVE5NZDUwOFJNcmV2aGVROWRESTlS?=
 =?iso-2022-jp?B?OUg1SHJOd3F0UEt0UnRvQi9aY3VZY3lLRDI3VEZUcUdhTlR1enl1ZmZn?=
 =?iso-2022-jp?B?U01hWXBOVFA1bWpFRjM5VElBZW9FSHdxeXdQMCtaWk50NW44cnR5ZnR3?=
 =?iso-2022-jp?B?OGhPQTcwYTNlekQrM2VxTmhIUWZNL0tKaWQwTjk0aUc5Wkw0N24xQVdr?=
 =?iso-2022-jp?B?enNkcytqNGt4V3JHOTQ5T09QOHAwOFB2clZqQUJ4UW5kbTRDS0hzZ1pa?=
 =?iso-2022-jp?B?N21jRXhVLzVjWThhVFBPRXExUHV1OWFzbWk1VXAwOVkwb2JlL1BRUXVj?=
 =?iso-2022-jp?B?NDFCeWVuUkJrYVZQZk10NFlkREx2Y1Fhb0RuYitMaWZSSjU3aHZlZy9P?=
 =?iso-2022-jp?B?MWxvaEFFZTZrR0JkYXNxVlMydjdVNUFTay9ycGlCKzdPT3RHcCtNVUll?=
 =?iso-2022-jp?B?MTNMTThYdmN2dit2dW53ZENaMkoyZnp6bkhGYlpmMlg4NDVQTytEeGZa?=
 =?iso-2022-jp?B?Q1FFaW1LcFIzdzY2aGluNm1UVkVzblBSaEliK3lyRkc4M2xmemZEZkZC?=
 =?iso-2022-jp?B?Q0pHOXRNQ3FSdUpqbUtHZFBPdEJIejVjZnRuRGtxL0Q0MC9PZ3hkQktu?=
 =?iso-2022-jp?B?KzJIb1hmSzBYR0dCTzl5cDhKd3hrb040ZlFzNFcwVVVlcmdmMERIOUkz?=
 =?iso-2022-jp?B?emNjOFlQbXRZT2J0OWZ0UExKSFp1NUxHUkdUb3daV05GUnJQbnBsbDhO?=
 =?iso-2022-jp?B?cGpZSGhXbDE2WUQ5R2FRcnBML3VjeHI4eWVpL2xvY1dxdVNCTXJGQkRT?=
 =?iso-2022-jp?B?RmNEcmlFaXc4QTRPbUJ2Q1gwb05xM2R2SGo1eTJxdk4wMjgxWE40RXJp?=
 =?iso-2022-jp?B?Z3pDODRWd25qdTFrM3UwMytVdGVpRDZPYmJJRU9kczIxcWhPS3Jib2Za?=
 =?iso-2022-jp?B?eE15UjhxYlV3M2R5a0JOUmVkOVBtQXFrL0pJYmRVOXhISW5na0Jac2Zp?=
 =?iso-2022-jp?B?YkV3enZlcjVYNXhDWVNXbXhIdjNSWE8vV0dUMGNrajNVWEtsUEtXZCtu?=
 =?iso-2022-jp?B?WFNTNUp3d1ZiWWtwZjhCQlhGYStMS3djcUJ5aGJaTU4yRDVXU3Zhd2Va?=
 =?iso-2022-jp?B?M2JoSHRaTUZXOFJsc2NvU2hFWDhEOU1vRzBuVHdaZkxUYXJDUEErOW41?=
 =?iso-2022-jp?B?aWM4V2VJNU9CVmw1UFE3Z2ZCQ255ZW1lMGs4MnpOMVZPd2dGQVM2eTE2?=
 =?iso-2022-jp?B?V2V2aUZCUTd0NHppeUJiS2xvdGI3R2kxOHRySklkcXFGOWM5ZGFqTGc2?=
 =?iso-2022-jp?B?VThYam1nUEdobHJsZ01WNzJGVTZPbU1kd3F5R25rcllEYjBUYk53Z2w4?=
 =?iso-2022-jp?B?VzZEMTBSSGthdGZLSjRVUDVQRDZIYmlQZ1NCa1BiaStGUm5BWnlSVDVB?=
 =?iso-2022-jp?B?WEw2ZGVDckRCT3RzcndYMno5ZlNSVUlOUlBBaytzSm15M3Vvb290engy?=
 =?iso-2022-jp?B?OWdmalVGTldFbWRZY0V1M2ZsaDVyVGpGTkovKzgyUzhnSWpDRVFvR2gz?=
 =?iso-2022-jp?B?elBSNnpMalA0ajJKWG9DNWIwMVo1MWpRdFhROEhTU1ZaUU0rS21hd3RP?=
 =?iso-2022-jp?B?cHNyUmNLejdnYXU1QmdRRTV4OHIwTU9NcVFpMi8zakU0MXRjMEVmejFW?=
 =?iso-2022-jp?B?RVIrZU9EcE54T1BLQjAzMkJESUVVU2ovcllZR3VmdlljQjZtSnhhcXVH?=
 =?iso-2022-jp?B?YlpGZWlKQ2pXOTUySlFZYmpIR2hScnlkK0dtS1k0RUxsWjlmMmlCa29G?=
 =?iso-2022-jp?B?WXJYNG1CN1FocHBVZFJ1UGVmbG52cTlieXJRaGNzYlZuUkNDMjRQVXV4?=
 =?iso-2022-jp?B?QTlOeEhPSFpkamMvdE1BNzRmSXRRODZhYjVtUVNwUUR2c1EvRm9ZMmR1?=
 =?iso-2022-jp?B?Sk9Nbmk5MHdVejBYNEVoWmlFQ0RzZmIySTZFU2g5TkJmUkdTUEsrcHYy?=
 =?iso-2022-jp?B?Zm1vaE12OFhyaCs4UGdWMVlGdXRRWGRQWmc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS0PR01MB6100B7D4C183871F0E47D056C2F72OS0PR01MB6100jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de37fa7-022c-4793-96d1-08dd45e82996
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 13:22:38.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLwcaZO0t22pUpPrNTpiKfjMW+wvWQDU4U8iZKEVc6bSPMX720STcFeyHSQxFcMOZEjGhKKm5moFmHQOMS/1NiciVcmNJQiXqcmdm0xbfaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11778
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 13:22:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17753

--_000_OS0PR01MB6100B7D4C183871F0E47D056C2F72OS0PR01MB6100jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

We did not want to touch the install path being /opt/ltp in all our test im=
ages except the case where the security image comes in to picture.

To answer your question about fixing ltp to separate installation from work=
dir,  I believe the LTPROOT variable is basically the install path in runlt=
p<https://github.com/linux-test-project/ltp/blob/master/runltp> script and =
in many areas, it works from the install path to access test scripts and cr=
eate results there. So, I think configuring the install path in our recipes=
 during build time can help us handle our read-only rootfs case.
Since the workdir is basically the install path, ltp installed on tmpfs is =
cleared out after boot.

Please correct me if I am wrong. After your confirmation I will re-order th=
e v1 patches and send v2.

Thanks and regards,
Sai Ashrith


________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Tuesday, February 4, 2025 6:51 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; cip-d=
ev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file as temp=
late to make installation path configurable

On 03.02.25 12:53, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  recipes-core/ltp/files/debian/{rules =3D> rules.tmpl} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/files/debian/{rules =3D> rules.tmpl} (80%)
>
> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files=
/debian/rules.tmpl
> similarity index 80%
> rename from recipes-core/ltp/files/debian/rules
> rename to recipes-core/ltp/files/debian/rules.tmpl
> index 06b9070..918b443 100755
> --- a/recipes-core/ltp/files/debian/rules
> +++ b/recipes-core/ltp/files/debian/rules.tmpl
> @@ -1,7 +1,7 @@
>  #!/usr/bin/make -f
>  export DEB_CFLAGS_MAINT_APPEND  =3D -Wall  -Wno-format-security
>
> -LTP_CONFIGURE_FLAGS =3D --prefix=3D/opt/ltp
> +LTP_CONFIGURE_FLAGS =3D --prefix=3D${LTP_INSTALL_PATH}
>

Missing default value for LTP_INSTALL_PATH - comes with patch 3. The
whole series is in inverse order, in fact.

But making this a build-time configuration will mean that there might be
two binary packages called "ltp-full" that are actually not the same
anymore. Can't we select a path that is writable for all our images? Or,
even better, can't we fix ltp to separate installation from workdir?
BTW, does it matter where this workdir is located, on persistent storage
or on tmpfs?

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OS0PR01MB6100B7D4C183871F0E47D056C2F72OS0PR01MB6100jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We did not want to touch the install path being<b>&nbsp;/opt/ltp </b>in all=
 our test images except the case where the security image comes in to pictu=
re.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
To answer your question about fixing ltp to separate installation from work=
dir,&nbsp; I believe the LTPROOT variable is basically the install path in
<a href=3D"https://github.com/linux-test-project/ltp/blob/master/runltp" id=
=3D"LPlnk" class=3D"OWAAutoLink" title=3D"https://github.com/linux-test-pro=
ject/ltp/blob/master/runltp">
runltp</a>&nbsp;script and in many areas, it works from the install path to=
 access test scripts and create results there. So, I think configuring the =
install path in our recipes during build time can help us handle our read-o=
nly rootfs case.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Since the workdir is basically the install path, ltp installed on tmpfs is =
cleared out after boot.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Please correct me if I am wrong. After your confirmation I will re-order th=
e v1 patches and send v2.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Jan Kiszka &lt;jan.ki=
szka@siemens.com&gt;<br>
<b>Sent:</b> Tuesday, February 4, 2025 6:51 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;=
<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.ku=
mar@toshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$=
B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@tosh=
iba.co.jp&gt;<br>
<b>Subject:</b> Re: [isar-cip-core v1 2/3] rules.tmpl: Make ltp rules file =
as template to make installation path configurable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On 03.02.25 12:53, Sai.Sathujoda@toshiba-tsip.com =
wrote:<br>
&gt; From: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.com&gt;<br>
&gt; <br>
&gt; Signed-off-by: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp; recipes-core/ltp/files/debian/{rules =3D&gt; rules.tmpl} | 2 +-<=
br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&nbsp; rename recipes-core/ltp/files/debian/{rules =3D&gt; rules.tmpl} =
(80%)<br>
&gt; <br>
&gt; diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/fi=
les/debian/rules.tmpl<br>
&gt; similarity index 80%<br>
&gt; rename from recipes-core/ltp/files/debian/rules<br>
&gt; rename to recipes-core/ltp/files/debian/rules.tmpl<br>
&gt; index 06b9070..918b443 100755<br>
&gt; --- a/recipes-core/ltp/files/debian/rules<br>
&gt; +++ b/recipes-core/ltp/files/debian/rules.tmpl<br>
&gt; @@ -1,7 +1,7 @@<br>
&gt;&nbsp; #!/usr/bin/make -f<br>
&gt;&nbsp; export DEB_CFLAGS_MAINT_APPEND&nbsp; =3D -Wall&nbsp; -Wno-format=
-security<br>
&gt;&nbsp; <br>
&gt; -LTP_CONFIGURE_FLAGS =3D --prefix=3D/opt/ltp<br>
&gt; +LTP_CONFIGURE_FLAGS =3D --prefix=3D${LTP_INSTALL_PATH}<br>
&gt;&nbsp; <br>
<br>
Missing default value for LTP_INSTALL_PATH - comes with patch 3. The<br>
whole series is in inverse order, in fact.<br>
<br>
But making this a build-time configuration will mean that there might be<br=
>
two binary packages called &quot;ltp-full&quot; that are actually not the s=
ame<br>
anymore. Can't we select a path that is writable for all our images? Or,<br=
>
even better, can't we fix ltp to separate installation from workdir?<br>
BTW, does it matter where this workdir is located, on persistent storage<br=
>
or on tmpfs?<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS0PR01MB6100B7D4C183871F0E47D056C2F72OS0PR01MB6100jpnp_--


