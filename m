Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3136C64ED8
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 23:46:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.33869.1677282405959156704
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 15:46:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 31ONkQuO011621; Sat, 25 Feb 2023 08:46:26 +0900
X-Iguazu-Qid: 34trk59Yi2Qv8yKi81
X-Iguazu-QSIG: v=2; s=0; t=1677282386; q=34trk59Yi2Qv8yKi81; m=yqI1YfmTuE4V3ula0rfIysbfUpCKw+uNybEGsVik0ck=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 31ONkOaQ002218
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 25 Feb 2023 08:46:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZV4RVk/3jnM+cTWeYboR9WqYwtVkIL+6m3MYY/+3jpqeIVU5rnUl0wYDQH1XyWzfx1HcVb7dEYLiiwfmGGwLCuyQ/rX1OaJUM0fHr5y1VTd4LKQ5HygWcpM52a9dro1vfGIwjjw9YrZ5EUo8Hp8+8FAY6Veb3n66/syRL7RpKg/BKtWQCiKXOqkYeBCaEgoUoEQMHRVYtQFRieeyX+C6bfEsWZgGaYCbLyi9mVET1kEVA6PofjR5yH2meWgXVGJrIII3P5WeDP07GE178K3yqHjlt6CsqrA5HZwLwDIzTGTAqv7M+evXfFWBytleIbAPTjAEwlRCLrPu6VFYR8sHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLUvnGCJFaSLudD0+AepQDP3fpw1h3T2zqisvk2zu3w=;
 b=HFXWGPz+xCaFjTtH/HSxGSYSazjPh1YCUuHlFM5rDlaZ/7WBXaDzfP/C6yuxCHh+Xz6vvW882GyrFw1mnOkFQFtHo23GVQ7NwK9tBjO2PjRjFlwtdQr6RlqIj630yi1FVtVVmDI37ThrZf0thh2TpJWsI0HGn9KGNx3HE0XjevyDm1hMif31ndt6C3fQPhYI+2dxQyR+8w07vXsam4KhXI11HgXaIFcEbOxNRcTpXMjbbS4esMByqUDLfyZSNIbphB9bs9zvLydKrAs1PmFMfB0ENmbmIO0GjEvbxa9BHDJsYoxu9n02yviG1R8Efu0p0cYoVSx3I/SpfvIoeuLy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v4.19.273-cip92 and v5.10.168-cip27
Thread-Topic: [ANNOUNCE] Release v4.19.273-cip92 and v5.10.168-cip27
Thread-Index: AdlIqgmHJerlnHDOQJiTdmUFq6zlcg==
Date: Fri, 24 Feb 2023 23:46:21 +0000
X-TSB-HOP2: ON
Message-ID: <TYCPR01MB9418ACB5738782BFC3FA908B92A89@TYCPR01MB9418.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9418:EE_|TY3PR01MB11608:EE_
x-ms-office365-filtering-correlation-id: 2b103ea7-22ac-4411-a073-08db16c1552a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aadyfvm5epvKe2BkaptvW7sjEg94rVvZ/d4DLxI776O+YvSaGoUh4X1ITcprK9fquCg0MRx7qm3ykiwyx4OCH6LO7lnSKud79Ow3fbXjbdYPsQrsVXU6cj+I5J5PIhUYTp/8hfE5xdQojN1M7NVxxoM4CIl57O3Og7v9Lj1qZa4sU/0NhVX0LJnEOu2eaP8Ia+po/oLJcoDekQhv7FAVqKIBurSLQm3iI0bu0SbLca4rvDMWLuwkJuvA+74rmnmT7elEBow6vRbzNabjPD89TFmqFaN4bWPm6b+zQXQcavC5H1NJA4ekM/+LL+fzFuglhyQPiAVZiahiAjAyI19ZGkpyQpQoMgOrMV3cQlZscRZFB/C9K1SI2H/a0fXGC7QNH5BAroJ7Q9+FzqKghTeiN7tTSH37TorX0DGFUQH2dnJk2WiFG/dPbHz9PXNxfPyxPz+xqj1sFfUxqO6/Z+TbP6NH+wmp2khw5uVDOSdEqZngbmt0E0/O1FSHTLwc6vPLBqfHfA1oBSyiKwYk6okq2xjRAD01YDW4Hz9chlpuoWMaBsXyCy6/zTLsLjZ2dzTCGvmKV1g6mKgxlHsoLrSn27Y9Evx3IWf0orcRufKpiqugH6eXNPP/0j0DfYRMgs/3kv0sRTzkZzdc4WxZJWRrLXpBHI/d0oadCRvTC4RtFJfJlsUQfhi/F64ln3aUt7PG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9418.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(52536014)(8936002)(6916009)(66946007)(66446008)(4326008)(64756008)(8676002)(76116006)(316002)(66556008)(66476007)(54906003)(71200400001)(2906002)(966005)(478600001)(7696005)(41300700001)(6506007)(186003)(26005)(9686003)(122000001)(38100700002)(83380400001)(5660300002)(33656002)(55016003)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cmk3cXEzK3FQVnhpWTVScG5Ud3c4UFRQYjh4TzhQZlpvVy9wZ25Wa1dL?=
 =?iso-2022-jp?B?QjF1YklFVlNMTVlGT3hZYVFDWW9PQ3QrcC95cVUxbTZ6OE5FWG5kNzRT?=
 =?iso-2022-jp?B?c1lDTUtwTTlWT3U2YnJMUkpOZFVHTXQ5VGFkRHloNGNhZUR0QnFjR3dB?=
 =?iso-2022-jp?B?K0VIc093Q2JnM2hnaFdHR0VBdmFLR3B2UzNzckgvaEhHZVFLR0dndmR5?=
 =?iso-2022-jp?B?MDNEUWFwd2hVSDRPKzVFbFExaVMvK0QvQno5ZWFxdERxQnlIL1dtZngz?=
 =?iso-2022-jp?B?REFSWWNoazZqSXNjeXVZV0xORkI3WDdLRE9teVRIZGI5OVBucmtsSlZK?=
 =?iso-2022-jp?B?V0hXZEtBcHk3VGVsVy82NXpXL295QmpPU2d6MVJPbUc3TE53WmI3YnJU?=
 =?iso-2022-jp?B?WWxmcndaMjBMb2k0YkhOMTkxSWsvcWFvOTl4OFJ5UDNMS3krWDFjdDJy?=
 =?iso-2022-jp?B?SjZ3MXJ5S25UMFowcGs3WG1SY2tDZG9aeTlLanRGTDFpY0FEZVFyaGtI?=
 =?iso-2022-jp?B?K0ljQnhmaFVPTkNQWVFzVnF6OW5Fd1JiNUVuZUkzODJ2VkdJL211aS93?=
 =?iso-2022-jp?B?TTNRQWdsRUsxZzR3amhMeXByblpVZVBhNitLWUNyWWRMS21WTmtsVXE1?=
 =?iso-2022-jp?B?RTBXK01jcHFycDdrTmh2UzRPOTRPb2RTQjNJSGN3NjdKbDdkU3EvREw0?=
 =?iso-2022-jp?B?UTFqMmk5ZWZEVW8zdlVwWTljZlRmSVRxOUdmYWtodWFqNkJpZ2pTRUhU?=
 =?iso-2022-jp?B?RmtiR2VaZ3VtTktMSXcvcDk1LzY4a1o5Vk13WGxEb3lENENmdFlmWFZQ?=
 =?iso-2022-jp?B?VEZVbE5JdUsvL3k5MENiS21GU0Z4VmZzaDIxNUNjakR6eW42UGlsMm5J?=
 =?iso-2022-jp?B?VVh6ZkxlYkZ1WW9JK3NNYUZIMFFhQnBjdGpHSU50MFVFK2dlVEZpTXg1?=
 =?iso-2022-jp?B?REJJc2FDL0IvWjNIMEVHR0ZHMlNmakFMNmFIamNPb29LcU5GcU0rM3dy?=
 =?iso-2022-jp?B?dzJpVjAvZzFxdHUrcy81djFnR3dEOVNhYXJqaVhJSkpBSUgzSURkTWFj?=
 =?iso-2022-jp?B?REExNWh6VFJvSWs4dmRPdUlSd01XenF5QSt0UXRDdE1PalU4aUdWUmxT?=
 =?iso-2022-jp?B?bSs1dGMrTVNpNjAwb2llYVBtaUZvMjhnSm1TRTBIMXdPdG9KZHhDNlZU?=
 =?iso-2022-jp?B?WTNUc0J3MmthdWMwR1FoWEJENDBwbURnN0ZLY2IwRzFwYk1ZeXJNczJU?=
 =?iso-2022-jp?B?QlA2b2N1QkJvcHhXWTQrNTFXdGVINVNVYkF2enZWMWo3cXhPcHpDKzBi?=
 =?iso-2022-jp?B?SFRXcExXWmI4Q3ZPT2xzQnRhNnYwVzlyRnpSZzNXSThWQk9xSDJGbDYv?=
 =?iso-2022-jp?B?NEUvMXgxdk96alM0cUkyYkNXOG90azhPdW9JMnV5TndyQmlwU2ttWXd0?=
 =?iso-2022-jp?B?VWFJa1lvNXVXRHVWR2g2VC95TDBuZnkzN2Njb0tHNDJBSERMRVoyL2pR?=
 =?iso-2022-jp?B?elM4TGlqdkdnQWNJcm1mL1I4UUplVTZmWGhtNEZ2N29XSEQxbFFIK0FC?=
 =?iso-2022-jp?B?Z0ZWNFQycjEwSDVIQmRuaDZaTlpqN01YTGF5RjB6dXphNGpqN2hYT2x6?=
 =?iso-2022-jp?B?V0djNnByU1JjY2hEZlA5aXdldmIrKy9QdmF6NG9iVnozd1pYVHRPeUI4?=
 =?iso-2022-jp?B?RTBDUktiQ1JLeUFYRWl1b29zZlVoN0ZrWE9oOUx6SnpNL3dIVDdXMlgv?=
 =?iso-2022-jp?B?TG0zQzZtVXFYNlZWaUxuVU45aTFySzJEbWJ4S2RVVEQ5WXlNNFh0STdQ?=
 =?iso-2022-jp?B?UEtSazVaY09DK1hyZVNsdWFmdTIvSnFkcDVWZE1US1lVUlhucTZNcnp0?=
 =?iso-2022-jp?B?VnFQUG9WbEc2NXhtdXRxTUFEUUZqWm54Q1NzVGhncEtvSitBenl2K05D?=
 =?iso-2022-jp?B?WUpyaUVNN3pCNXhUaHEyeC9kYUx3c0EweHJVV3QyR0FzUkp3YzJFMGsy?=
 =?iso-2022-jp?B?TzQ5VjJUdjl4d1VyRlhkQUVXamxZOE5aRlhIVEZQRVg3aWVBV21oTFRU?=
 =?iso-2022-jp?B?eXV3blhMa3dyR3FveDFrS3NjdUJ6a0xuZGppRHpWQ3R5bENNRENKNjE5?=
 =?iso-2022-jp?B?N0YxbFVQblZtV3hBTVlZNklCSXJuOEk5LzBhajFuaktraFRvVHRRRmZa?=
 =?iso-2022-jp?B?VUxQeDkxd2kwM3V3N3BDSThFNTRBSFFaRmxuaUZCbkVVRWp6QWx6dzVY?=
 =?iso-2022-jp?B?UXJ6RGcwQ3ZXOHlZd0o2SnkrdU95dE13MUdTWEtaOFpINTRBbzFaN2hP?=
 =?iso-2022-jp?B?MS8yVkgvM0YwR0dBQ0RSazNZWHcydER3TXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9418.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b103ea7-22ac-4411-a073-08db16c1552a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 23:46:21.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8E0XQJ7MYVPDsSG2gPPZA4aZqRsIoGaCHaB+IujGx74+jbyAkmmfcpQpkeHRqhiEs4c7w1qTPGLTkjzJ6c9wJgG8f3dxzVW8v0nYlFcAK1d9QI59QAYMYm3mXPRJ1Qm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11608
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 23:46:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10830

[ANNOUNCE] Release v4.19.273-cip92 and v5.10.168-cip27

Hi,

CIP kernel team has released Linux kernel v4.19.273-cip92 and v5.10.168-cip=
27.
Linux-4.19.y-cip tree has been updated base version from v4.19.272 to v4.19=
.273,=20
and linux-5.10.y-cip tree has been updated base version from v5.10.167 to v=
5.10.168.
Linux-5.10.y-cip tree has applied fixes of Renesas RZG2L SoC.

You can get this release via the git tree at:

  v5.10.168-cip27:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      cc82f737b68c179240070fa34771bcfd0a5fa421
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip27 after merge from stable
      pinctrl: renesas: rzg2l: remove unnecessary check from rzg2l_dt_node_=
to_map()
      watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks

  v4.19.273-cip92:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      13b591404faff8a66449dfa80682930f5325b869
    Fixed CVEs:
      CVE-2023-23559: rndis_wlan: Prevent buffer overflow in rndis_query_oi=
d
    added commits:
      CIP: Bump version suffix to -cip92 after merge from stable

Best regards,
   Nobuhiro

--
Nobuhiro Iwamatsu


