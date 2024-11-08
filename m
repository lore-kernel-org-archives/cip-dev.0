Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A84D5E14B
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 09:11:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.8972.1731057091396582912
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 01:11:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=LHosrVTx;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1731057080;x=1732266680;bh=/5sbAT0xQZW6nLp4//DRUvafMViJsxia4pvOo29
	mYU0=;b=LHosrVTxxsSjy2rFMXx67HwR4rGnam0pvHFz65f35+BbPcvfizU6U9Dnjx0CyCGt6kOZS
	NG9hEXX49j4PF6xxEdG82UZZBPsKZ6cdGDDeXbNRLUcxfgbgcUQ45d+LJa83VTyPY5XopUpsJ6CrL
	QXaSujyG1CZS4Nvqlz/snIMMR1Ot2jHPb6YPyrc113dTZMpuCLVa869AdXGlsI6F6FUE9vDXqVYHO
	ja5JYcdTS0WEYxxxJquxSWoQo/IGXWt7DpkGJLc2PYVLKJ7PnfXw2yCzTGR2mCuh/rzRE8lbzWBes
	+Y8Rh9Or8FGUN0Y+4ahcWmRcAj110b8MwmGJcwwA2A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4A89BKh53105514; Fri, 8 Nov 2024 18:11:20 +0900
X-Iguazu-Qid: 2rWgO3UeJ1ui7mQKxM
X-Iguazu-QSIG: v=2; s=0; t=1731057080; q=2rWgO3UeJ1ui7mQKxM; m=xsBv6YmVeBnLxBN0OfFT+dKt17T6qXvAKgjp6GIldIo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 4A89BJF23488681
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 8 Nov 2024 18:11:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENYvzrjoBLyTBlScqYNqod162va/r0hkMAILhptqcKDgp8IMM4OSgLuxI4u0Q4HXC4lRCfi/eGXFrZRg5eeenaqIZna1yB22bwpBVjWTvIQ9N9eatgVQxW/P5MJSckNIbj7JTPMgvymtc9ZpcWHMAevYZuU1z8/HZskoVtccZdBVIe+OLltuqol/l4p+Om77SjqUywBzLKvcGSQyDYyWLmxxaFaVfYAgTOWm24wxZvrdcR/kzoI8nF8dFcgmSZ3wWDw60t1+i5lpq8alR/5XEYJXlZkkCfrANXQlOPjc24FPNf4zxgzB/aM70zO+1obH5WK7F1vr9veFtUJdNdRhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o89IGBU1j5ZS0/ygAmZthTFVjftIjVXdmT2TfeU5rPY=;
 b=F5zxKggZ2BWkiNh8w12NhU1M6uK7v7UJzaAz/JHNfgg2xp9kc2KCo4dmxZshx7eHHhkMCyLCDOvP1Zkl61AU400B4duSr80RWEh4QhmqFGln/lDXQ9Llvy5RpJ1GzB6MHkVw+tpf2bpPqWy2EFwG9JN8OVj+I/n1D6BW++xAtom0C9X47jm/sK7bx6CBURV9kANLutiBJMaQFdW9QCiwW8GhZ6m1CsPGb74/W6nx/dxHXZFFVC7vitBcplS4n8f9jmf7t7N1xkABTyAmrj4KfVs2odSj+AKkNWiZsRfRH+0M24HzgeyFAPUXMMcbHyLJqJo5TTKafotgm7FkxPuafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip v2 0/5] Enable CRU, CSI support on RZ/{G2LC,
 G2UL}
Thread-Topic: [PATCH 5.10.y-cip v2 0/5] Enable CRU, CSI support on RZ/{G2LC,
 G2UL}
Thread-Index: AQHbMPkAWmS3QQyRaUKw7hzXdgW2LLKtGa9w
Date: Fri, 8 Nov 2024 09:11:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638880836390C77391267A04925D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS7PR01MB11902:EE_
x-ms-office365-filtering-correlation-id: af020652-780e-4f51-208c-08dcffd54ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aEtTbmRtSnNkL2lVMEdjaGJoa1ZITWZVa2QrT29KOXY5V051cG1WN1BW?=
 =?iso-2022-jp?B?djZ5MGFnSFR5Nk1DT2xWUUs2cjhwZ3VYa3Yyb0F3dEUyN0ZDU2tXc2JC?=
 =?iso-2022-jp?B?Q29hMi9GM3NIbVZqaDNFZ3NiaW1ONXAxWUg4dzVQK3hSU01oWXMvMVdN?=
 =?iso-2022-jp?B?QWdVUGNvS0U0Wm9zdGNudWNmVndMa3VqODgvbXcxM0RQazJNNXFWcU56?=
 =?iso-2022-jp?B?ekVtNktOVzk1RFRkVkJXVjBmSmRGYk9VbEFCYlFxQmt2U05pZ3BXYXdm?=
 =?iso-2022-jp?B?RmRMbm1ydDR1cTlwVHo0YmxtR0pHVlVUTDMwZEd6aGdDYlpjMnUvYjlO?=
 =?iso-2022-jp?B?emZOWU5kSERWZU1ZSmNLcStSWU43Z0sycjcyblVybEpKaHlURlNqVndX?=
 =?iso-2022-jp?B?cGVkSXE2MHh3VDc5QTduMlA2RWk0b1FnWVgwT05DK0dYSW5JN2Nrem96?=
 =?iso-2022-jp?B?bDJCNkw1ZHZyTS9taXdUcVN5VGxHOVQzK083NzZzeVNpczFNUWtMRFgy?=
 =?iso-2022-jp?B?OVVpT001K2lVMnBMeU1QbWRZb1VNSlA4ZXdOcCsybCtpQ3BXZzF2N3Q1?=
 =?iso-2022-jp?B?cW9iaTZiR3lvYlJTOE1ZdUJxb3N2R3F6WWhmS3BIZ3RHUE8vS0hRWnJQ?=
 =?iso-2022-jp?B?QkxtVlJSc2hNYjhzc25iUEw5RXo4ZzJGREhneEptR3lYTlBUSmdRcGVS?=
 =?iso-2022-jp?B?Qkl5d0pWMkk2UDZXcXlGUEpXU2pqT1Vob3V0d0N1OGtRMU9LL2liZ25P?=
 =?iso-2022-jp?B?cGNNWHBCVUt4bTl2ZDJwaXZ4REJ5RE1RbC9icHVudE1ibUhobEhodWVU?=
 =?iso-2022-jp?B?ZFRRTVpLSlRkTFZOME9LWjlaanlRbVA0Z0k5SEZmS1MzZWFER0w1Uk1i?=
 =?iso-2022-jp?B?eVVQNkFvQTBQYW5Fc0VsVGZhbE1YbXNELytUaU5oWExEakl4TW5aNFUw?=
 =?iso-2022-jp?B?RU4xc3JDUEw0YjFXWmtCYVpMZ2FZYzM3S1QxOWltcFZ3eUwzSHcvdmt3?=
 =?iso-2022-jp?B?YkxMcTVsU0VaVnViNHBKSzRnL2hoa1R6NzVBWEsyZDA2cmZRcmhHcGo2?=
 =?iso-2022-jp?B?L0JEbmsrVTQ4QndpMHF6eDdManJZWUZjcEpTaDdIMSsrQ1JqeEFIU2Nn?=
 =?iso-2022-jp?B?bmR6aE1rZlF1UWcrdWdwOXdzTXRpMlFBOS9Ec1BFVmZyYWRUQWxxVEFX?=
 =?iso-2022-jp?B?bVVqKy9pRzBBeXRlME5qbWdtZG84VFpPUDNFOWtaZWdRT0NadXlUalh0?=
 =?iso-2022-jp?B?djViOFBxVFlQcHhhaGpiVitWeERtaXdTb3g0WmludnRxVGZaU3FlOWRR?=
 =?iso-2022-jp?B?TXZobjhsWnZkY041OW5VOXdENGFxaHQzODczVitYSmo2L3cvR0JjY2dN?=
 =?iso-2022-jp?B?L0lVcmpneTUyWks2bGJ6RmZTM0p4S1VkYm01WUJuakREUGRTR0VYSkRy?=
 =?iso-2022-jp?B?VHNyMVBtOVd0MUNmK2RqeDU4TzZDZGNVUDVlTXduL0h6alBvaXBRWE9B?=
 =?iso-2022-jp?B?dUhIMlZYTmFaN0l1WUM4RXdqU0dwY2V0cjR5WG5aOEk5b2dlaktjRzBR?=
 =?iso-2022-jp?B?eUtMYkF6TG5FcjloNDJrajdKSlZNSUk5ZGU3S3VjVVMvek9uZnlYcEdV?=
 =?iso-2022-jp?B?cU9YNmFBNkgzM29tWHQxcUMvM1U3dlI1QktlTXkwc1h2MzVjOVVJOWNs?=
 =?iso-2022-jp?B?MGZOL20vekFsSFh2MGJZeWZYTkNhTlIwMFhRcGVkWkNMc0tGMFZWMnlu?=
 =?iso-2022-jp?B?L3pvQ2pmK0pnK0EyZkJQS1UrdXh3TUNDQTZQWkowdW1RSVNiMG9ITFJz?=
 =?iso-2022-jp?B?clJ0ZTI2dzlMVGZHV0MwYUxsZXB5Z3FYYVlPYWl2RUgzR3Q3ZFZSelRX?=
 =?iso-2022-jp?B?TzduQmpWZG9rYnlmcVF2ZUo0SjA5aGlyQkdheTdocXIrWm9aQ2hUc09h?=
 =?iso-2022-jp?B?OVJqc2hwZmQ4b1ZiNVN0K2dMdkZFQzJYVi9wWm9Ya3g2SUVBZ1ZtUlBI?=
 =?iso-2022-jp?B?LzVncnJ1WXg0eXRVQjVtZ1dibjN0Y1JxTGhRMEM5eGVCR21OM1R0SG1j?=
 =?iso-2022-jp?B?VUE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dC9YOXNmZk14Wi9sbjBwcWw4WVZsSm9OVUhiQ3o0R1hXaEtOYVNqb3pN?=
 =?iso-2022-jp?B?N3AvWk5sSkRRL0lRLzdIZHlYNllzZmZzUlFKSW40R1I1ZElsZUdab2ps?=
 =?iso-2022-jp?B?MHBaaWs1c2tRN0xLdFdNNEM5S0JlUGlmQzI2L21RMXlBaFJ6dUtoWTcx?=
 =?iso-2022-jp?B?TmJKR051cjNpc0sxUkxhOFJqaFNkdVZZUlY5M3hoYjJMcmptbStZSGdF?=
 =?iso-2022-jp?B?RGxtWjJJbGRObXFEL3F2Skp2V244Q05mQW5yMThiTnZRMXZDdDNLd2kr?=
 =?iso-2022-jp?B?MzZYbXRGVENjZ0FIZnJ0cG9hcGdQNEdJV0xtK2VPOEhxSUh4akJ4K1Jj?=
 =?iso-2022-jp?B?dFQ4d2JrTzlpRXU2Wm1JMjFhTlVpWFhuQ3JLeUdzREZTY2JNVVpDUTAr?=
 =?iso-2022-jp?B?WFQ1eFhUclZvWElZVjN1Ri9vdVFLYlkrVmk1S3ZxWFhSQWlWVFZVNzkv?=
 =?iso-2022-jp?B?eG9RVUNmMDNxYktLcEdhdkQ3a2NjYzFER0lCTW92bHZaZ0ZmdkVQUVFv?=
 =?iso-2022-jp?B?SE9jRE1Ia0pzc2RIVXEwZng0a0gyK0NXOEE0SURadWtudUhnZ3JzK0cy?=
 =?iso-2022-jp?B?U1VncFVDaDQ3enVwU04wZlZKRUJwYytWSWVzQmdEKzFzZjdrNEh1S0NO?=
 =?iso-2022-jp?B?cmZ5dnNLbzNGaVBVdmJud3hNMVVhbGZCd216VFpPQUNGelRqYWlYdG1T?=
 =?iso-2022-jp?B?aVhmVnZvMndBYmVlc0F1N2hkOUxrVWRTejZnZmJqUU1UNnFyNmZJZHdh?=
 =?iso-2022-jp?B?KzlNdE1QTkd3eTJnMERob1lLVGpxTmVzNzErcmVGckhXSXJvVFRPYlA2?=
 =?iso-2022-jp?B?aEhqeEM0VTJnVWJ1dnZNWnRBckFVZmdlN25hOXZuenpKMFNsU1JlSXdh?=
 =?iso-2022-jp?B?YUFxeGZSa0dXTG9XWE5sUExsK2VsTjdzaWtlQXZTcGJQaDZqa3k2dmV0?=
 =?iso-2022-jp?B?bnhJTVNXWDNLa0NocnpIRG9Bc2tNQ3owTUJjdzFCcEx3WG5jbWpxMVhO?=
 =?iso-2022-jp?B?Mnp4UHhmSndqZnp1SlJSdFhNb2YwU0xkcVQwRCszZVcvbHQvb2twUVBo?=
 =?iso-2022-jp?B?MGtTNjdRYmVETDNOa2lRblFRNmJtK2ZRZkNneVlXeWczL2J1ZjVId1lK?=
 =?iso-2022-jp?B?WGMvcXdsTXRjMkd3cnA0WFZvMS90Tk4wYm1IS2xINVFMWExyN3BuR2Jj?=
 =?iso-2022-jp?B?NWRNN1ovTjNyaE5VeWNQeFRpeGpzOWlyYk1kb3BDMVRSUEtrZVFjM0x2?=
 =?iso-2022-jp?B?RGUzRVN3Q3ViM1lrRFVhamxwLzh1V01jdXhKS0tmMHhmRE83UUYvZU84?=
 =?iso-2022-jp?B?RU1lemZLT3BmUi8yMDVJb0xIUEN0dXJ4VzBWUldCME93NjJVcGlEcHVl?=
 =?iso-2022-jp?B?TjFtcWw2VzUvRmNJYXEydkE4M0JkMkdFRTNWSisxdGJFMVhIUHNIdGFp?=
 =?iso-2022-jp?B?cWhjbjVpTWhtQUNsajFHR2JwRHloQkdBUVlJZ005QVZBTHFwNjNZUzNw?=
 =?iso-2022-jp?B?SU5JV09TWmN6K1laOUF1N1ZKS2xRcUpYVW9mNXRwSHNHZXJzcEJMQk5D?=
 =?iso-2022-jp?B?Zk9RNDRPckp5NmlkUEFrOFFrMkRod2FnSzI3bzllOUhJVm9XeEJXVmlx?=
 =?iso-2022-jp?B?Z0lOdnV5eExaTzBQQzhST1h6bk9RNHQ1RXpudTRMRzZYMUk4b1VVeGdT?=
 =?iso-2022-jp?B?WFp0YmxXU3ZWQnJCcW9UbDlKRFp4MlVyMlNjR3JSWjRqKzFMUHNuSWpi?=
 =?iso-2022-jp?B?bFVnSWZqajBCZmZJQVQrVkN3bnk1aTBnUTF2cVdreXdVTzltVGpnekxj?=
 =?iso-2022-jp?B?RFVrbFVWTzZCVGo1Tml4TnN1czFDbnNMMUpWeTYya0I2NEhvUG9Pd3VR?=
 =?iso-2022-jp?B?NWMxUXc4S3oxcGgzcG84cVd2T0NPSmVRR2t6dmhxSlJsL1hvYTNaZGk5?=
 =?iso-2022-jp?B?cUMyZ2dMOGlJbW5KRnVmUGtONnI4TE9IS1JJWlN1bmRNUWpLTWhOb3d0?=
 =?iso-2022-jp?B?K2YyTkgrNlo1RVlYRzZ0MWNWK2pnL24vcXVnSDdJN2N0OXlDclBCb0M3?=
 =?iso-2022-jp?B?VVVpSTF6NElpTDN6bEhaVG1ENmZ1RnR1eTBwV2V1MnByZTJLMElhQWZl?=
 =?iso-2022-jp?B?dWRmSnVDbm9mSjdyYlU1R2tQeDdOeStpa2kyeVFkYmcxVkQrL2orc0Zv?=
 =?iso-2022-jp?B?SnlrRTEvVVRNZzBXTE1CT0VJMDF2OE0zcVdhNDIvMW5KTjU0b1VEZnZw?=
 =?iso-2022-jp?B?WlQyNjJqZDNhS1luK01TZUlBSGtNejVnQ1ErZnh2OGRSQ0pBWllIZUI3?=
 =?iso-2022-jp?B?VU5Xa2VINWhSOU9FTjFIYTljaHB3MnFtM3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af020652-780e-4f51-208c-08dcffd54ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 09:11:16.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AY8tOxhQSSeVX7dLCbwPlesOpEYgq1ipXUTKP0fuB+zHPqb8z9VsWwtz+AQUNEf0Q8AuV7bAixosrVuiHPQFAM/PdNHEiS7LLbGXnzq9TZRmpGXMyOULPnhNhJw/wC+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11902
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 09:11:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17224

Hi Prabhakar,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, November 7, 2024 6:39 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip v2 0/5] Enable CRU, CSI support on RZ/{G2LC,
> G2UL}
>=20
> Hi All,
>=20
> This patch series aims to add (and enable) CRU, CSI support on the Renesa=
s
> RZ/{G2LC, G2UL} SoCs.
>=20
> All the patches have been cherry-picked from upstream.
>=20
> v1->v2
> - Fixed build on RISC-V by moving the enabling of CRU and CSI from
>   rzg2ul-smarc.dtsi to r9a07g043u11-smarc.dts.

I've confirmed that the build issue is fixed. Thanks for your work!

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1533048163

>=20
> Cheers,
> Prabhakar

Best regards,
  Nobuhiro

>=20
> Biju Das (4):
>   media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU
>     block
>   media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2
>     block
>   arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
>   arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support
>=20
> Lad Prabhakar (1):
>   arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support
>=20
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 35 ++++++++--
>  .../bindings/media/renesas,rzg2l-csi2.yaml    |  1 +
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 69
> +++++++++++++++++++
>  .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  8 +++
>  arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  8 +++
>  5 files changed, 117 insertions(+), 4 deletions(-)
>=20
>=20
> base-commit: 0351950bb8213297af5df9c503242886119127a0
> --
> 2.43.0


