Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197F8C47DB7
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 08:55:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.17830.1705654551959203492
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 00:55:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 40J8tWdM1854055; Fri, 19 Jan 2024 17:55:32 +0900
X-Iguazu-Qid: 2rWgwVXgOfp3TdkTas
X-Iguazu-QSIG: v=2; s=0; t=1705654532; q=2rWgwVXgOfp3TdkTas; m=neyaJQLjeTGgn+J8JCMgzdia1d+qMdnQI6tYqVeMwAE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 40J8tUas2360117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jan 2024 17:55:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgHe/snZC1pqvbc6dSgNCJce9UiujF5tCoUnLuBIW4q8x7ly2M5ZBQHcEM7yw18jaz5FG27RtlK/w62lJY8TDrsUV1n9e9p4ZfTNKvBbnwhs5TJ+W8IRMjmqQWW6jx2D6D+8ML70WOOfo32XidEEqnDDfuhKlgKWCE7nN2JaRv+4oR15Jb3cCJQvD880rkJwi6NBg0cLoPQ2o7ESuNJAOTb+k7xw7rOm7igkBCifExNndd2INYaBpZSzFnf8DKHLJJSqfyQOI99lY8EY6z0M72j/ckF6xGDoxzCXQPfyGkWyViIU+mc+Ai9V16l6AU0JQlZcX2nn/lEdBjFiLYCqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/5ekCsC2rqfW+JabYbgEjKuXJLgaP1K/C9tASv8HGo=;
 b=JKI/3nS3G5eM+KHAtdJJ3yxwsESHYj9xs7onPOVvf/iRl0nPAMwI2aP7RJeoql4dKVuLNt5Aiyg1j3dx+KDdseFqM5TQ/kescrDrAGbhimrYS2uootfXFTtcrGVePXxFNnRx6p4iaHu5kOqNkQucxwcfl3jRWgwLEScVKN8gW6iFj+M+ULQi/04HClDtIINoaovVEibCghVu9sqf1Av3miEMG7Tw8rXlvTSFFI4IaqvcafRCCSLuc+sAvs8gnqWCO164ZAIxeptWpgiGR2BVYmF1RlNvUGZsoWwwqjKboJ1f783GfS6gbGrYL8g+sYha0Wj+dZXP84sBNBD7up6VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.208-cip43
Thread-Topic: [ANNOUNCE] Release v5.10.208-cip43
Thread-Index: AdpKtRh0mVlCbqIxSX+7kXZlaPr+Lg==
Date: Fri, 19 Jan 2024 08:55:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638843317C0D8CAD4195EAE792702@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB11048:EE_
x-ms-office365-filtering-correlation-id: 747eeee2-614f-43d1-4031-08dc18cc6225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yIRlGIwqjMVpLZ+m16UOtWS9r01DJ64rZ4yN8dgAFui0PCYhCpQzcVvPwBoh4cfoewj76F/RwBB29VL/wFHhEl7Ya969ZSGJN62ilTZr0PaqFrst6AJ5l6JvkDDZF+Pup1JnJx+3FOIANxTJLDKpc0005giqwSRWoqQYNoXpYwr5ffGwTioH/7Xy8aKPDhRutXWQx3JyNxlrMN1q2+9Lt62RPZs/I1T6p105vg9nbxhFWvsu4TQ84A5WTleNz3uZ2/Jqq5kqAabVcNwtCDev2qFBwjJkOMrQoGbENr+E+K63BC9pCH4XInZUykF8VsLaVDQ/4adegFZ+d+rs4QYva3fPPHAxF5swMDlOeY6b4i9xlLWyvEIXIzyTBlMhgiYEm6F2lgHYyQJ7zIy9bIf78vtQqtmRZs2rGVMqwRwNG8E4vJMOexhscMtIa1WuldnToOBC3g4GUJ3y+ed1ySzx0/HwXXyJMexdpKc5tDJ5mx/s7GhVqHrW6EZxVzyCoj/r+W7ySmNK1uKXe/BBdg4nZk4Caa1thzLhlIdqJMbx7TSQFpho/Oq+DvlVV2/U0+pbTxD7j/kzfTXoIyFCPvZahyhGHAXsf8C3asr5Om6KTodgrRmhh02Zw2bjG4drlYXUGaz1w3MldJmJqdC8BvWISw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(52536014)(4326008)(8676002)(8936002)(76116006)(6916009)(55016003)(64756008)(316002)(54906003)(2906002)(66476007)(66946007)(66556008)(66446008)(6506007)(966005)(38070700009)(7696005)(9686003)(478600001)(71200400001)(26005)(122000001)(33656002)(83380400001)(41300700001)(38100700002)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bk1RVzh1R1ZJejlPaGxiTDdUb2t1V011cldhcjE5Zkw2SnUwRDY1Tmhp?=
 =?iso-2022-jp?B?QW5RM3d2dVhEeW94QWYyMm9ielNycnVLNDVaU21QTEJ0ZHJpcnJaZ25O?=
 =?iso-2022-jp?B?eWpQODd2d0xMUFY3RDNrK3dGb043aHlYbUNtY0E5MFRqM2JVTnYzVjlO?=
 =?iso-2022-jp?B?RUg3eUdFN3NVV1FXZXNaYXZlNm5zeFQ2WEJ4NkEwQ1B0RittYmFMdGxE?=
 =?iso-2022-jp?B?UytFNnBrOEZDa1hIUk5aUUlqT0FiOTJ4ZmJ4bXNIYVdRNWpCdE4yazF0?=
 =?iso-2022-jp?B?NCtvVXQ4STE2R0RzNnBHaEpZL2wwSzkyNW9yWGJxZnFkLzhDS0F1Sity?=
 =?iso-2022-jp?B?WXRwdWliMkJFN1g5U1VEWFFWYmpjcnlZQ29NRjZBODBrci91T09yUHQz?=
 =?iso-2022-jp?B?Tk9RUkhXN21xdS9nVVFwKzZZUy8rdmFoVG1Bcm5tR0Z0MDhTb1NaTm5h?=
 =?iso-2022-jp?B?VHQ0dFVlYUNTVjZTb3BxMmd1OVdEVEFmUElja2pONVRxd1gwbUpaMTlE?=
 =?iso-2022-jp?B?L3Q1RmNmVm4vVlVSZ2o4cFdpU0c4SXJ5ajg4RjhvT1JLd0hWbzdVbzZi?=
 =?iso-2022-jp?B?eDQyWFNRM1Rvb3JlVnJWaFhYcjNROFdQVlZnN0xHR3lLcE1YempMU2Vu?=
 =?iso-2022-jp?B?eTBleTkzNjJ5dWFDYWcyQ0JUemU2b3VadGl1bG1MelE0NlliT1lhVDh0?=
 =?iso-2022-jp?B?MkhSSkZNTis3QVY4bnF3aklXaUlBVW9VN1p4dE5wSFVmNDdUdld2NlJM?=
 =?iso-2022-jp?B?YkVXMk1GZmxxazBmTU8zaDMyT3V1Z29rV3FJbGR5SEN4RnJEbUtkZlVR?=
 =?iso-2022-jp?B?MDhRV3ZXalpDTHd0OGRiYWlvanMvNGRaaEZiaDlUNzV1VTFuVHJlTjZG?=
 =?iso-2022-jp?B?Uyt1ck1oQTJseVhGMEpVaEw2N0tNZlN2NUtrWUNhT2kvWGo4SkxiVXV4?=
 =?iso-2022-jp?B?SktsTUJUV01qaG5TRGJDK0dnWk84NGFzcVIvSHBqemJHcTVmNzlkYkla?=
 =?iso-2022-jp?B?MDVFbjNIU0RQajU4c2UvZXV2WlZqN3hYZzF0WlFyYzlkUmF0ODc0SmZm?=
 =?iso-2022-jp?B?YjMwVnFldWlNeVJlck0wdW0vcTRZUmRRR3ljV0lHdlR1ZCt3OGFBVm1y?=
 =?iso-2022-jp?B?MTBvK3lPWlovYTlvR2JZQ3A0bE5SZ3FhVzJmMWtGTVp5MXVlbzFrTkNR?=
 =?iso-2022-jp?B?NlVBSmtqZ05EL2RDMmJ3VG1NM2U1Q2d3cFphQStaazBSclJPamFHRjlr?=
 =?iso-2022-jp?B?b1IvekZYeSs5RC9hUjBoMjRUSlRtMVpqRHQrSDNYWGpiMXVwL0hZaDVH?=
 =?iso-2022-jp?B?MkxDZVgvbjEwaUExNjJRQ01LcmVkVGRsamhlSm52UzNlVldPeENwRStT?=
 =?iso-2022-jp?B?eTFTcVV4MnFSQ1oxbmRXOXJDVEdoS0gxNUZQVmFNTXUzbGkrSVI2d0hu?=
 =?iso-2022-jp?B?NmpobWhSbGpNSWdlQ09rTElwa3U2ZWIyZTFGSXlmdThyeWE5RUJzWkkv?=
 =?iso-2022-jp?B?V1VRK0xYRDBWNDhTdkxHMktsUVdzM1ZSQWliRmcyb0ZkenQ2TTBPa3JE?=
 =?iso-2022-jp?B?MkJGSzRmdU4yYlJjQmt3NVIydER0enJ3S3p3TjNETDE1K0hUamcwMTlE?=
 =?iso-2022-jp?B?OVduTFRMYUVVdlZBZnNpeGpKeXFGbjdPN2ZrRTRTMlVLdlc3ZUIvRmlj?=
 =?iso-2022-jp?B?UFJwM2R0d043VXovdDVLUUcyQXpEdTFSNTlsd3lMOWdSQzVMZER0VEpX?=
 =?iso-2022-jp?B?cVNKcmhRSmljaVhkQktGU2kyY25wRUJES08zMS9pMHRYUUoxRUVsVkxn?=
 =?iso-2022-jp?B?ZlduM2lKOTdqeWZJVTZBUXRXcEJnK0JUcHVjU0cxNVB3VEY5aFVNV2Rr?=
 =?iso-2022-jp?B?VUJWT05MbkUwbWZWcG5TcEdvdWFXK3d0dTVjNzBiUlhnZ2FXWEZKNEpw?=
 =?iso-2022-jp?B?TUR5eHlRYSs3Q0pHcnlUTXU0RzRQOHhveDhzRkRBM1FWdS9TT0w1Y1RH?=
 =?iso-2022-jp?B?enBhTTBwUGhMYXlUdGdLWStLYkJhZ3VDUUlLMmVzTWI5Mk1NTDZJK2FG?=
 =?iso-2022-jp?B?S1RQbEZtQXgyUkVqU1cxWG1CL1lQYkNKeklKODQzK1plU25ZMjB6clhL?=
 =?iso-2022-jp?B?ZzBqcjVVemJEK2M0SE5iUFlWSDJRaGcyUmNtZnp6Z09sT2FyNmZ0c1BS?=
 =?iso-2022-jp?B?YjVJZ3kyV3VzQ0dXYTE0Tk1rOXhhcGppY0gwZUVPS2gvQUJhTVBOQmRk?=
 =?iso-2022-jp?B?bllYejhsOW8zUUxmQWNpcjN6VkdWUjZoZkh2WjhTbGFocDBLNDFrU01i?=
 =?iso-2022-jp?B?UFdSMWdRMktVRmd6aVNkNlNkRys4YWRZS1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747eeee2-614f-43d1-4031-08dc18cc6225
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 08:55:27.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULVJK0z9NT8ejKP4x85yi5pecX71y3QyPd2LLENMRBSTRrr49QUAlcHOjnPsa2c7nWdGeJyQDJvAzt3B10KxYPzKJFFIud2/J/tJyNN8DmyzTIDzPOkOETXczcOdFxZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11048
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 08:55:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14422

Hi,

CIP kernel team has released Linux kernel v5.10.208-cip43.
and The linux-5.10.y-cip tree has been updated base version from
v5.10.205 to v5.10.208.

You can get this release via the git tree at:

  v5.10.208-cip43:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      b445cc998c55d40197d601584361f73e1183d44f
    Fixed CVEs:
      CVE-2024-0646: net: tls, update curr on splice as well
      CVE-2023-39198: drm/qxl: fix UAF on handle creation
      CVE-2023-6040: An out-of-bounds access vulnerability involving netfil=
ter was reported and
               fixed as: f1082dd31fe4 (netfilter: nf_tables: Reject tables =
of unsupported
               family); While creating a new netfilter table, lack of a saf=
eguard against
               invalid nf_tables family (pf) values within `nf_tables_newta=
ble` function
               enables an attacker to achieve out-of-bounds access.
      CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize
      CVE-2023-51779: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_soc=
k_recvmsg
      CVE-2024-0193: netfilter: nf_tables: skip set commit for deleted/dest=
royed sets
      CVE-2024-0228: [netfilter: nf_tables: skip set commit for deleted/des=
troyed sets]
    added commits:
      CIP: Bump version suffix to -cip43 after merge from stable

Best regards,
   Nobuhiro


