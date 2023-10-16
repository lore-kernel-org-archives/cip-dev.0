Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A3ECDB482
	for <webhook@archiver.kernel.org>; Mon, 16 Oct 2023 21:12:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.180247.1697490739016468615
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Oct 2023 14:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 39GLBsbc1996991; Tue, 17 Oct 2023 06:11:55 +0900
X-Iguazu-Qid: 2yAbF3oT7sUIliiix6
X-Iguazu-QSIG: v=2; s=0; t=1697490714; q=2yAbF3oT7sUIliiix6; m=QH9j1uqDCMrfCbkmgH9+fNwFMj320wiLQLEcR6ip0As=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 39GLBqPE3935829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Oct 2023 06:11:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAtdzBkHyqMYKBZPKIrov+m7hg+pCFbBPDRGcPp91NkLVFsIF2AfNKKbxTikmFQWXe1rhpTCpr6nyc9LMNR1RuM7nAN7hrcgkddegZVlDFPTAN3kVryGDysDWEUL83omj0PCzp2sGFb3TJlZMzh6ADTD/mXiNVGTexgN1eGpnaq5fX5FNTkk1wv9B04GKgegV+H/Ma2Yh8W7clo3q39Ay/SUAzp/TTBV7BjZPoLTBDl4mkvCRT9vyMWpYNHf2MLA5s4sY6XX/bQajdQreT+h4B5VGegMr9d42qC5ZQchQBM7bjrlp6Ak6KI3ONH7Ho92cNXWIwQBawW07q71Maxk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sELwVaN5tmvLS9LE0AGDRN+i4TBQt21P2PkFCvfiOqs=;
 b=NxHK/6SIXGwmkVtIC1vRCpq5BG+t6pKeE0biBCLgSXuVGS+BzsQvILcPa9JrYRBPB0ctmmJ2ZggD7y8s2sLTWkD9TEzhl2qpga7ocbGWoz5dtOfIdTBkQTBD8XoAo+r+zLyfbcryHyOvTinM2lAJW9cMWYjkp8OccRXIhZgEv+M2Oy6WosoprkrRmY5Po3M0vM1YWOWAtvLokwjuEoYs5Xd6/biuO7K9jcUHwTFyjMA+XsFAZC1GTZ56tA8/lYTeDmi+jsteYLGTY161yhQ5N5WAFB5jrmbVjzDxk8/5i2T5aEFmyIoaX1Ziba5tFgceNDzFvDL5mR2qYScwCviM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.58-cip7
Thread-Topic: [ANNOUNCE] Release v6.1.58-cip7
Thread-Index: Adn/5iVAetfbIJzgRR+PEXk1kBxjdQ==
Date: Mon, 16 Oct 2023 21:11:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB1124578A54E5C0F1A5EABA0CD92D7A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OS0PR01MB5409:EE_
x-ms-office365-filtering-correlation-id: 54553309-d54e-44b4-0842-08dbce8c8355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 E81QyV+Brl9MXGnnYiFC+EINNS1U0/NoiQxKpQSU5wVdchSrgvZjJ4WYngKxvUCBI2yqViniVhmMeS+hK7Cb/i8+nuwfi4myxsPrVYen3fa6GHOVGpEtBXOA+NzjWv77LwTCC8oiqBXu9pW9F6J5AeJU6jiUzFfMJofogyfVm507jtfrd6ff4MAIyPWT3g7QBAmi1H7PkOwv7p7qMdoEVMfYf7/CSyQH+WbkivbGFFsq6WzWXen0Rb9F0Fh7uPdUAAfULVRTogys4vcKyNkiMkcBgRcplBduIOOKZwOQwuYagoPmPRCG65Yaw6k3F0qnFIeW2PWJRyQT2cyTVVY4v7kAr19cmT8eUVHsRKr9X3fBwvM9KKTY4kCa/1Ul0Z/xjszLZ5sVrzJj1O+egjF8p5dZyIraL6hi9S1UcBlWnh4bo147CMcaNSlur5lqZEkXuoxiX/vHbpQFJGMD9ag8pK3dh+kQsKpxgGW/XtSHOapC22+niW2LRMUEt7r8z0gQXivK5hh8FPYuo5I7AqzH3FjWx/CuoOJ16UkaWA4DbAyEhSSddze0HGNB2l7fAADGLDA/7Shabq0TO/rO6PHcl72KAV1UBuGWzIVURHuNPexHFnxfHehW1VvmYjw9DPKa
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(83380400001)(4326008)(8676002)(66556008)(478600001)(66946007)(6506007)(7696005)(966005)(71200400001)(8936002)(76116006)(26005)(6916009)(64756008)(54906003)(66446008)(66476007)(9686003)(4744005)(2906002)(33656002)(52536014)(5660300002)(86362001)(38100700002)(38070700005)(122000001)(41300700001)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S3FOVEdNOFh6b0cyaDdXWituNDlGMXVOR2hWc3RiUXhFRnRINXlJcys0?=
 =?iso-2022-jp?B?TS9XSGpZWTNUV0cwY0I5S0RLMEFyemNrQ2RRRGJUMHpyNkhDemt2ZTZS?=
 =?iso-2022-jp?B?WFhjcC92OHgxS2RicVlPR1lISHYrZTUzNkNYcGJEd2dZdGdEVG01VTJJ?=
 =?iso-2022-jp?B?Qk1nelJCR051Rk5OV1J1V3MzREp5Tzh5eVFlNldjU3lEM3FhYWh1OFZY?=
 =?iso-2022-jp?B?aVIram1Qalg4dDVkOTU1UzBWU0JwS1czK0p3VU1jN3JyYTVoYlN2SmNT?=
 =?iso-2022-jp?B?MzR2ZkswWllRVERKMXBsOFdoa2kvWWRlcUFHMVJaeEpCQnh6ejNiblBO?=
 =?iso-2022-jp?B?QTdDbC9SQTAwMGE4SVBhUkw3WnBXZTB0aUpXTU9xdjlGVUd1ckVNTzBE?=
 =?iso-2022-jp?B?S1F5N0Y3KzBUaWJOdE9XS3RsMUIweEtIRWtYNjJZQkYzS1hITkpVdmh1?=
 =?iso-2022-jp?B?eFp2TnRTM1dxVHhYbnhRYU12ajhHWWt2dkY1QzI5Uk5NaW90NGJZUXZO?=
 =?iso-2022-jp?B?MDJiS29yU2pQTSs1UXNWaUVrZHBIQzRtdngzVitSV2U5TUxpR3k1T2hX?=
 =?iso-2022-jp?B?Y05wZzRmOC9LWmpXZklGWC9EOTNoa0gvRjdydnJOVmMxWk5hbkhmUXQ1?=
 =?iso-2022-jp?B?SG9PS1JzRlRsT3JIZmRRL3JpZXFyY2E1cmJENUIxakRlMWNISHRaOEVa?=
 =?iso-2022-jp?B?cHR3eUdFczlVKytTVWNWZTFia3NrUTQ3akhYbnIybC9zWmVncnhiSkZq?=
 =?iso-2022-jp?B?MmM3czg1OWd1b1E4QzZQQkZaVDdHNGJ0WlpyM2JIcXFlNjRJZWxMbXBP?=
 =?iso-2022-jp?B?ZmVzajVPaW9NNldzS3FZbUlxUFh4SjhYSW5DUDJiM1FTeE05R1lsRXYx?=
 =?iso-2022-jp?B?d0NHanFJQjZHOVRETXd1UE1nZSs4Nk5uRjdpV2FHczJxcVJLanFPYzZ5?=
 =?iso-2022-jp?B?andOZklSVzl5cEdwdVpuNnJ5Z3BFY3pEN0tqUFNFdEJQdjVidkUvM1VJ?=
 =?iso-2022-jp?B?M3VXdjJteExUSjhORldBRzJBVTBsWFdVc3pvSmdzb2pkWENsd21TdHBM?=
 =?iso-2022-jp?B?R2FiZWdhWUx6QUhNeGpCWWxkZ1JuVGlBSjJRNWZiOWVac2xYRkdPLzRt?=
 =?iso-2022-jp?B?TVRucURnblFDQU96M1FhRXJ6Z0Rmd3hDdTNXVHdndU12NngrbTJvZmht?=
 =?iso-2022-jp?B?T1pqQ1NjODYvNFg2b0J3TlZTR2xubXVENy9wTHZJanllcG5kM2IyNzlx?=
 =?iso-2022-jp?B?a3hnTWRBQW5VTy9qUmlCSXpsbHB6RkprMitRR1d6Wm9HdWYrYmdDZ015?=
 =?iso-2022-jp?B?empKT3BhUS81RW5UNjAvRWlJOHZVL05QU25JUFd6d3A2V1VCMDJud3kr?=
 =?iso-2022-jp?B?blExQnNhcEFDTUtTVFVwanpISnFyS3VtY05Dc1NNUTVKb1VLdnV3UWdO?=
 =?iso-2022-jp?B?RG1CM0hCVmJnSDNEaFd3dWUvcVVEYnFpRnNWdzFrWmIwWFNnaU85eDlq?=
 =?iso-2022-jp?B?VDBnNnVQNFA3Wjk0allha0JLUllTLzFvRll2bDZKMExreTlUZGozVENS?=
 =?iso-2022-jp?B?bXZMdkVwTCt0OE5XUVIvOUd6dE92TXRnN2I3NHNEN3QrZXBydTBhdjVJ?=
 =?iso-2022-jp?B?MktNb29IK0pRb0ZlY3pGSjIrRjdaL0VURTV6VG55azhvQi94cll0Q3RK?=
 =?iso-2022-jp?B?ZmJDTjdpWi9OZTl2aHN2bTY1T3JMaVA3clRGSUovek41QnNZS2Rpa3pM?=
 =?iso-2022-jp?B?MVhkZU5nYnVSWDNGOFg1ZEJqOFdOYVQrbDRaUk5MUmhYNmpwR2VXY2Zn?=
 =?iso-2022-jp?B?ZWJaWjBoUlZwTHN6b1Q2MUdXRjZaWUZyRXQza0cvRDc4K2xRY1BsVURm?=
 =?iso-2022-jp?B?WDlXNExUWUwxdTl4UFF1OEZJaHN6MkJrZlJ1cEY2OXA3dGl2SHRmYUlE?=
 =?iso-2022-jp?B?d21FSVdWVWR6RWRpZnJlU2Vyb1lzcjlOenZGc2FUQTZvOVlNSVlsUFBt?=
 =?iso-2022-jp?B?ZStCdlhxNWZMeFVvRGVzZk5lOEpsNzdnQkpMRVQ0S1NTVjBFNEEvQUR0?=
 =?iso-2022-jp?B?dDllTFJhYUtlRlBJOUxrUkIwdDFVR1ZwVG0xS1pSTDdwTzVqa2NJbjJs?=
 =?iso-2022-jp?B?dU12MllWdDgxL1RqYkVFVDA1STVJY2hlNnpvSS9SYjEyK1dNRWRIbzEv?=
 =?iso-2022-jp?B?MFllVUFuTHA5YTRzM0JqWjRsS0ZnYlNEQnN0eU81M2V3SmVXTlcxRHBM?=
 =?iso-2022-jp?B?QVRsSU96QkhsWUFFYk40S0xLV1ZMNzRkU200Y3BQejNLazQyOUxJeHBh?=
 =?iso-2022-jp?B?RlU3VDRDcS9CNW9HVFZSc0lUaWNBY3FnZ1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54553309-d54e-44b4-0842-08dbce8c8355
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 21:11:49.6795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBKotNCdbb4NRzX3fpS2aba3ICFS8EU4MPrEjjjck6O0iG66II+x+gQ90bQrN/EreofRDGMT6Xvi7HTMeeKJXCmXOUeN8CnWbDTEgRJuSptM5fNQqK77BWnmfnIPLQkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5409
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Oct 2023 21:12:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13397

Hi all,

CIP kernel team has released Linux kernel  and  and v6.1.58-cip7.
The linux-6.1.y-cip tree has been updated base version from v6.1.54 to v6.1=
.58.

You can get this release via the git tree at:

  v6.1.58-cip7:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      5608f0095a5ba83c76af0e5824c2e2d3f41231b5=20
    Fixed CVEs:
      CVE-2023-34324: xen/events: replace evtchn_rwlock with RCU
      CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's n=
etfilter
      CVE-2023-42756: netfilter: ipset: Fix race between IPSET_CMD_CREATE a=
nd IPSET_CMD_SWAP
      CVE-2023-5345: fs/smb/client: Reset password pointer to NULL
      CVE-2023-42754: null pointer dereference in Linux kernel ipv4 stack
      CVE-2023-5197: netfilter: nf_tables: disallow rule removal from chain=
 binding
      CVE-2023-42755: wild pointer access in rsvp classifer in the Linux ke=
rnel
    added commits:
      CIP: Bump version suffix to -cip7 after merge from stable

Best regards,
   Nobuhiro


