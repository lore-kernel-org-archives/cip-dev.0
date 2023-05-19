Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448EC77B7A
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 13:26:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.26377.1684502759579109221
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 06:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 34JDPZwb003530; Fri, 19 May 2023 22:25:35 +0900
X-Iguazu-Qid: 2wHH8MjPamM8jW7FyK
X-Iguazu-QSIG: v=2; s=0; t=1684502734; q=2wHH8MjPamM8jW7FyK; m=uZGZ2ArUkgbWQfewxZfBezzFpoxoedLAGQccidMPkuI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 34JDPVVR016517
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 May 2023 22:25:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da9KFhqHFNil/E/lO/WErDWfabTPvTVTajKkbock+LcRmCt2hRw+1IGlU+QOfdpSLM3wXMPyAZu1qmBEI3sM6OIsdJJGxYEp5/QDDkCsZH6TM0wCuV4SPkfmlyYN5pvH3scCsG57skxEfqKLkkJcyhiLHkYrIRjE592CXzhISiWEXS4yZK8BbviDjkLnIc6r3j2owGgd4p0cX3Asy5hnVhORu9CP9k2P01vt85nEhifxAfCO08JAnQo9MwyAFlZC4jlF25m+OuWSeaR/qiUYCR4T6TfjGQS5/T5IQ4zkAQIz9Y48DQvajGjoRuzZgTjbZAPKNo+uwmRBAKDveRu6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc6dceV7nWFaAQoR88EuH/9pudAcSRd6P8EDWtmvo+g=;
 b=XoKDjZABK4ZTSi4pnVf1d1DjpPd594rIMw+mpLEzQvdXngF2gVKQFSooG5SOA3jOh4q9qyPFRHcVAo2CEmpEdI5cl8N2ICZQaYm8cd4kRq8lhJ5ZpjgWLA9AI9IC9c0qXBK8J4Uuxc3JQ+itSz6M3ymbNobiPKCiuE4W4ILOASUbZbbOQ+HlfBt+x2jFq+xmxEDQgefKwhi54IKNwbUm+nLdPEfJtwZ9MPqCBhzLcnG9T5Y/Aba1T7ygfkdIUINUAY8FMiOfpMz11sWNGnCViOj3lwGw802d5TMrIRi1tZuGb5rtevXOR7xf2GjKlwCmFuY4Qz9NvgZQuaphiqAE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.283-cip98 and v5.10.180-cip33
Thread-Topic: [ANNOUNCE] Release v4.19.283-cip98 and v5.10.180-cip33
Thread-Index: AdmKSuTIBCyewtRGS4y0iZDdbxjRTg==
Date: Fri, 19 May 2023 13:25:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942054323C2B2054116F22B7927C9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB6230:EE_
x-ms-office365-filtering-correlation-id: f03d1720-d687-48ed-6c90-08db586c83d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mlLqBl2C3OigG2VSmLfo1PtjXvNrJpZ1Nwqlkq7mYENMlhGuRYYCB5LeEHO4LAdPGV5rVK8e/mEwZsD97Q56P/EKxDtgsdPxGisYE0S0zeW8S46G8PK/RTrClAPKtY7hr2sE816GDMdT8KjB+f49DzZimyY3l4D3kZvKDfeM/iNxXsHbEW7WN2EsUMjJWjeYV6DbRjIINqwUGpCVmRK0DDmEDixgXzvmakZRAn4lOVutD5XUQ7tcPxh+X/ek4L2yY3cJSPwsX/sh+msDAGHmF+zchQ/B/bw5ZTcL+y89nDKgUjKFJdSwYnql63GKqCbr3QQ00JZjzcUmBYlKEMQ69ONvfV5krdVTTORimqOZJoAp731ralpTnhWyEqcEb0Dms2FNYhhawrBhg2yuIzaIliAKQ7BCektuqqH57RY3PbE/JVEXvtOsc72+BrPAEdSQBqOri7+39Qh3gig2n9Cgu/pgTXZjnWeFaPHNkAmns3jeGWzmTUTpprdAq73811zbFpExnD0abOEKNFXRU8LH9SsmEe+bwjjcufLE1/qEK7+vU+qVN5UDP4U44zshYlcHaqhaO2+YKiRCPVeIecLYxMO2WfKuvbrFIDLK3NIOBIxsMpmJaO+n+M/bDScZecgZ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(66556008)(66476007)(66946007)(76116006)(64756008)(54906003)(7696005)(966005)(66446008)(6916009)(4326008)(316002)(478600001)(26005)(41300700001)(71200400001)(5660300002)(33656002)(8936002)(6506007)(186003)(8676002)(52536014)(9686003)(55016003)(83380400001)(122000001)(2906002)(38100700002)(38070700005)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S0gwL3NiWmhoOVVTbGlrekdXUytOR0JQUEk1eGFBWkoxSkdpME5JSlpZ?=
 =?iso-2022-jp?B?bGxpeUJJZFB5ZGpXYzNqNnRSTGZ6OHpFLzBrZ0ZxWElwVnNVL3FDMFBZ?=
 =?iso-2022-jp?B?azE1ckdOemMwNFh2L0k1ZVFQcmhSTmhEaXlxdS9aUXpieWttTDZtcnh0?=
 =?iso-2022-jp?B?eDZBQ2NUczZrenpNZGJsajRqT2hvNDVzTW9qOXVLYjhaUGdqWHZDVjJF?=
 =?iso-2022-jp?B?SktFRkJPOHBOWHFhb1B5cjRZRWxYNGlzWlNqQ1h1SGdiZmlYMDlUNTVi?=
 =?iso-2022-jp?B?TURkazBHNkFoelFDUnRwM2lVY2xwZS91OUpXVTd0dFV2eG8wV0VnKzdv?=
 =?iso-2022-jp?B?RnY0aXJzS3pxVXFoY2NEOFF1U2tTR0c5SW9zcnI1SkRWTjFPZm1XeUhL?=
 =?iso-2022-jp?B?TUhYK2JSS0xpeEozUHRkUEprRGNJMkhnU21hcmRHeXY0a25nZUpZeFVw?=
 =?iso-2022-jp?B?NnRCYkJiRG0wQitEeDdUSFZHZ2pwb2pWbzdxY1d5ZXNHWGsyM0VzQXE2?=
 =?iso-2022-jp?B?T01IdXJGS05MZlRFQzZabi8vcmhJWWJyWm10TmpTei9vTzVXeFlqb2ho?=
 =?iso-2022-jp?B?WTFpRWpEQzdyMks2bHo5TndYa1g5R001Wlo0ekFXTnArZnM3M1hqejRH?=
 =?iso-2022-jp?B?YnVLMktHSTN5b2ttazl3Q1ROdUw1R3FCUWhYb1dYNEZacGF6WGFLM1NH?=
 =?iso-2022-jp?B?OWtYWkFsSW05MFE4ZUU0UGoyb2UyT25xOWlpTVZLeVZsU3NCV0pPc042?=
 =?iso-2022-jp?B?VE5YRVlZK0dGTkNXNGJqeC9OdjdlcVZNMVFkYys4NXo3bU9BQXZFbHMz?=
 =?iso-2022-jp?B?RFRsWjYzbzk0U0tibzBTZXBCZmRrMWYyaEFHZmY5OUt6dFJYN2RwMUdC?=
 =?iso-2022-jp?B?SWdGaExGbm9jL3Vqei9wbVdMYSt5R0l0dTQydW1EdE1PQk5XdzVUWkFp?=
 =?iso-2022-jp?B?ZFByYklsSlJBbWJieFdxSndNb0xjTEJaM2x5Z3BENUZZTlpsdjkrNmEx?=
 =?iso-2022-jp?B?VFNyaU9ZY1BPRExpS0JvMVQ0ZzhndDE5WWdmRGJjeVpXcnI1bDVLMVpU?=
 =?iso-2022-jp?B?TE9mTmUxdGRVSWU0bnQrQUFQTG9IVDJ0UmlpL2Q1T2Y2OHdNVmxNSEh0?=
 =?iso-2022-jp?B?UzJSSklEU1oxRHgyOUtmdk13TDJPMmU3Q1BEWXFpWi9WMWxMbStQVGV5?=
 =?iso-2022-jp?B?NDB1QVNkaTErSHR1UWJrVmhuRmY0M2JMQ1RWdDRlSnF5T3UvUTlZZDVm?=
 =?iso-2022-jp?B?cWdzL01UQk13TDFiOWV5eWhZd09DWFZBVlFKNGZoU2doU2Z1T3A1M0lG?=
 =?iso-2022-jp?B?RUE4SzJkSUM3OGxvRDYxSXRQUDczbHBQQm1BaHR6WVh6dFNidFRyZmFZ?=
 =?iso-2022-jp?B?WDNOaUNEcmo5b1pZcDhqOG01SC9jNEhBbXdaYkQzdXRmOVFkclpqMWJH?=
 =?iso-2022-jp?B?T01HamlsdHBmNW9IU2FHUTRST3VReHcwKzJobVJzb1h2MDYzQmRMdVVZ?=
 =?iso-2022-jp?B?RGYrUG5TZDY4SEMyaW9iL0VmYnJXN1c5bG9lNk5Ybys1dkRPbnU5UnlO?=
 =?iso-2022-jp?B?Y0M5dkZUenNXekdwNkhEUzRRdis5SGkvTnJQR2o2TVdldFVTc0dSZlNz?=
 =?iso-2022-jp?B?TDVwR1pIcStDLzczVUs2T1cxNlVxZWRCcUhaeDQ3dFNvY0RJQ2VFMUxB?=
 =?iso-2022-jp?B?QjcvVnV2ckR0dnJKTDI1N29KMmdla0R1UDduQ3k0S2N3K1piYS9qU3BS?=
 =?iso-2022-jp?B?UFRXTzIvQVh2VHFQWVViUWdtd1hKb1ZKb3o4eTFIMml6NXlqckRqdk43?=
 =?iso-2022-jp?B?Z3BtZU04NjcxcnhtbCswWEowSTFVYlJiTVBlVVdOTmJYUGR0eVBROHBG?=
 =?iso-2022-jp?B?RjZ6NmNJNjRVYytIRUdCOEdkUEZLMVNvM0htc1RuYmMzMlZmci9QeFh2?=
 =?iso-2022-jp?B?UVFJN2NaN3UvOSs1M0NHSFEydTY4QkwrUlQ3TmZHZ2NIVHNLeTdzdHdx?=
 =?iso-2022-jp?B?WkdSSTFDM0Q3dUNJZEZxZE9SS2dQUUI3ejc1S243UmUrTDNwbkZKdGlh?=
 =?iso-2022-jp?B?YmMvbEl6QmxlRXpTdmxvSUVSMkEyeFZIVE5ZWjY4bU5VZ0xVVisyTzlO?=
 =?iso-2022-jp?B?aWppNkI5VmREbUlObkkxOG14eE5UdXR1MlVVTW1QYXU5d25ZY0xsbkdQ?=
 =?iso-2022-jp?B?NDhiRDFKQ3J1NW9sQ2N5alpqb21GNkduU0xKazQydlBITFpsODJPVmcy?=
 =?iso-2022-jp?B?QmdDRVQyTGh5VWF4Uk83Um5yMm8zUlNKNFhGN3dObDc1LzF3NmZ2Yktr?=
 =?iso-2022-jp?B?cEsrNXAvSFpmQVlWa3JNWDU4VS9nTWpqY0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?dndnRGZMSGxOMlE5STEwUGRyb3RqMDRKTGNGbGdQcWJSYlFlK2cvOTJJ?=
 =?iso-2022-jp?B?Z2Z0S1drMkJkN0tLNEV6Yk4rekk2WWpLek14YjBWT21TL0ladG4ySFZz?=
 =?iso-2022-jp?B?ZW1LcFVLbVBvQ2hRTGF1OVBRWE5XbFE5Ym1EanpRVGMrQVZKeWJidXFQ?=
 =?iso-2022-jp?B?aDc4aUtFU2ttZXptelVUandMeUVxUnF5cEk4SFU3T1pRSzVyRnZBZjdy?=
 =?iso-2022-jp?B?WFg0SnRLT0JGWk1VYTJpS0ZPSTA5Ykk2cWZhMXZrNm1hUFZBUERtN3l4?=
 =?iso-2022-jp?B?K3JaTTg4VnFhZVZRRVZGR3pTUTBKUjdock5SU1I0eDVSRm9tYThKSy9o?=
 =?iso-2022-jp?B?TXRXVjk4OXRRendZc25jQk1BLzRYUGZXdExac00rWU1TS0MrUzBGUmpL?=
 =?iso-2022-jp?B?aUNHQ200N0htYTFWSi9IRVdXRUVvcXRENlhyeGRRUERjMzh4VTBpUGlH?=
 =?iso-2022-jp?B?WjJMcjhaQzk1WGY2OHZLSlJtUjZtNVdnSUZkbnFJQnMzMVJ6NnF3VWlz?=
 =?iso-2022-jp?B?TFZ0aHQwU1BaWGNWU0tRcmVweGlHUnF4WlZYYzVSY0FSZ0g0SjB3VEZ5?=
 =?iso-2022-jp?B?SjZ2SXZFcnhqUjB1WDZIblY4UEZMV1FpZUNLaUltRzNKSzFoajFmZzBO?=
 =?iso-2022-jp?B?Z2ZhSS9paFAwVnFIZFJvckRxM3JZYjNITVVZd0sxUXBRMDd1czBGNklZ?=
 =?iso-2022-jp?B?cVhia05jZ2ZPaTNGV0Y2SWdZOGNvb3MvT0NmMUNNL0l5enpHRVE2a0Js?=
 =?iso-2022-jp?B?SFhpL2ovdkdxTmYxSFNrWS9jYjIvdk5QVWp6SG0xaHllNER5N0ZScmo5?=
 =?iso-2022-jp?B?TnNrN0pZY0p3TDl0VUduSVJlRFRtczc2NWZDWkhWOXk1cFFIT1ExaHp1?=
 =?iso-2022-jp?B?NzBrRWxJQnV6Mng5R21rVGExZHA0SXViYmRadEM3aEFPWVZFdmxwMFlU?=
 =?iso-2022-jp?B?VE4zVVUvYWZ4OUV1dmcweVJSa2IycW5tWjhLcytrdjI3RlpkYUVCcHBl?=
 =?iso-2022-jp?B?Zi91amhvb3lFZklQUUZ3VWRNSXg4LzdMVG5NZG5rSUlMd0NCNVE3UDk4?=
 =?iso-2022-jp?B?Qk5Xa1VFWU8xRUNxRmFVZldtMzB3Q2JnM2NERmQ5MW9WU1doYzVRZDFy?=
 =?iso-2022-jp?B?d2plaDR0N2RZL3NhM1drUk9TRTNneEtsTWF3U3dCQnV6RWZOQmJzQitm?=
 =?iso-2022-jp?B?SjcrdG03b2tFck5DWlhFTlJBdVJ0dE9kODBDWnFVRjVXengvMW12ZENC?=
 =?iso-2022-jp?B?L1JLODd0WHpCelcrZ0F4cnRDWkNhVTM5eU41bUNmYnM1bnVJaWZ6OUxi?=
 =?iso-2022-jp?B?Wlk1SW0xS2xRUU9GbVJaR3VLUXVEU0Y0VHJUUzRWWEptbmNBZ3BiNEsz?=
 =?iso-2022-jp?B?L0QyWkV5SXVWRzJVbXY0dz09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d1720-d687-48ed-6c90-08db586c83d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 13:25:29.4603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmQE6d9wO4qmmUN19osvHmKQmYbIC1TqnYlyNLEy1OJTyUzH3nMQbs4T/SN3Xymg1prxntTeYJLVlMNjw/aRZafZQmWsgr2skuJiyAz5W6OajRUFhA9upBNwR5t7PP4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6230
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 13:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11556

Hi,

CIP kernel team has released Linux kernel v4.19.283-cip98 and v5.10.180-cip=
33.
The linux-4.19.y-cip tree has been updated base version from v4.19.282 to v=
4.19.283, and the linux-5.10.y-cip tree has been updated base version from
v5.10.179 to v5.10.180 with rz-dmac patches.

You can get this release via the git tree at:

  v4.19.283-cip98:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      31603fc59adb456f6eb0f58de8bb989b41572c2a
    Fixed CVEs:
      CVE-2023-2269: A possible deadlock in dm_get_inactive_table in dm- io=
ctl.c leads to dos
      CVE-2023-2002: bluetooth: Perform careful capability checks in hci_so=
ck_ioctl()
      CVE-2023-1380: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_a=
ssoc_ies()
      CVE-2023-32233: netfilter: nf_tables: deactivate anonymous set from p=
reparation phase
    added commits:
      CIP: Bump version suffix to -cip98 after merge from stable

  v5.10.180-cip33:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      7f6b02104eb287caf662ade9a67f11896ab01fde
    Fixed CVEs:
      CVE-2023-2269: A possible deadlock in dm_get_inactive_table in dm- io=
ctl.c leads to dos
      CVE-2022-KVM_VCPU_PREEMPTED-guest-TLB-flush: KVM instruction emulatio=
n doesn't clear KVM_VCPU_PREEMPTED, breaking guest's TLB flushing
      CVE-2023-2002: bluetooth: Perform careful capability checks in hci_so=
ck_ioctl()
      CVE-2022-39189: KVM instruction emulation doesn't clear KVM_VCPU_PREE=
MPTED, breaking guest's TLB flushing
      CVE-2023-1380: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_a=
ssoc_ies()
      CVE-2023-32233: netfilter: nf_tables: deactivate anonymous set from p=
reparation phase
    added commits:
      CIP: Bump version suffix to -cip33 after merge from stable
      arm64: dts: renesas: rzg2l: Add clock-names and reset-names to DMAC n=
odes
      dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size
      dmaengine: sh: rz-dmac: Add reset support
      dt-bindings: dma: rz-dmac: Document clock-names and reset-names

Best regards,
   Nobuhiro



