Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF881C4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 00:06:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.3597.1670630767316439375
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Dec 2022 16:06:08 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2BA05jsN026431; Sat, 10 Dec 2022 09:05:45 +0900
X-Iguazu-Qid: 2wHHDMt2N5NRwddGy0
X-Iguazu-QSIG: v=2; s=0; t=1670630745; q=2wHHDMt2N5NRwddGy0; m=Kh26zbKRqXPzTZzqo9QzNS3PykA5VbRcjtLNo7y3LEs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 2BA05fbO019319
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 10 Dec 2022 09:05:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gatpVE7jKyTWW/h4Q+1dqgj8Sn1Cc0rGqAaWkgSvHC/mpxgAGCqpFrdrl36eJNNJ/BinbCvzPHUR7TJdXpsNcsvZGaDpsRaJkJVa1mAHN6f3+/NFuBRWS/9ONgl3MqVzuUj4OwExdVM/hTQbsZRCaq9XogxFM46d4itxf7YOmAR0L2cWUNezrmeYY98AyGltHWLlffFdpYYhjwzsvcnzROkSNd1u1bWWuAFSzbRzFnQjbQ8wfKv5NtasNi11bRT5vmrsOu3uW5VgV3KoUmzdhmS4eJkEU9TNnhwqGcxVHWx94E/NvthVAvyUPQeD4i8KUnN/j7aXlSX28Wp0ObS9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2FAvgAyZUrO3FjrE8ADOKmDKZhjg1YF1zGR7Z6a7XA=;
 b=JTjiAsxMTb/xEL++rKlqKHRo8ak0piU2R+NEvMOwmvLQ6LZ1afVtMLLS4OeSaGSt79NNp4kN2VvFW+oeR77mmHXGNId1+tO/rLLMu7/AXK8T3kLJwNbqGuqVvns7MgLpUTazboJzCpo5+Y2oQmi/ziGhJt8B4lRz/xUh5UZrtlMjEMzgO+dgwG99/0P8utwznSlC1ingHRk3YD4gt3kAlrLCTGRuGcwd5eKV9Q2Rvpm+Z/OHuy6BVeBfHdv/eV4aGP+vHSXmC3Aqhi3SJZ3hsEQzSIm9RybwSPc9lhI/wOER1z6t1E5S7olFvhIdTz1NmF1V18liGxvor6MtFivm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.268-cip87 and v5.10.158-cip22
Thread-Topic: [ANNOUNCE] Release v4.19.268-cip87 and v5.10.158-cip22
Thread-Index: AdkMKvGhCafZrDkhTaGtDL7002iobQ==
Date: Sat, 10 Dec 2022 00:05:39 +0000
X-TSB-HOP2: ON
Message-ID: <TYCPR01MB94184C0BFBE4575239CC5D05921F9@TYCPR01MB9418.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9418:EE_|OS3PR01MB9639:EE_
x-ms-office365-filtering-correlation-id: 8d05e56b-4d06-401f-6e61-08dada42455d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HEQQ4UkMhQIKdpjy3R3nEAHWCY6hWPzDEJwseSF5AMTl6zVhEF3chozBvlDJ47+TEPy4LFG2VB15pLrdAI8/MBE4cFTrBK5R06iOO9tfw1BqfgXNx8oFMt0eFQrZUmlTc1jCorMpstTbmKNV6liq8tbEVzRttMdfsrlr3fdHAo9YHJv3wdJNO0SrkKvcrSMPDd1UrL4KYTALlw0NZECifYIZcgFxD2fz/oRiJsVrPUzVmzyLD+dPqOqkhYfXcp0b5YAvASSZgKQPIF6G1RldadwnEaUDx+k1ocTMc/GlRd3BiBvzzo2JaM8IWC9FDaREtrazDG7j2r88T/YDHNSTIOWoD0BQT9IfvzDYsjQcnSXslyjrWSEptqt54tyRbOc9fVwwmUG8hMyfm+VL0euxgi+rdb1miiRTTHSV+Glo9wx6WazBmdGLjv4GCAtutqa0CW3uJoXahIPXpy+DikY5L1AQM8gEMY0eRhgHIoa4kb7vFYtNlXsqqf+6wtCyuAVfcM8IVh1zbocOk0kmfm5MPkrOoL9MlAOC8ZGFlnl/4YxILuxpffTiQestlDxsvGhhxDIhJiJ6G7LOTpr9vrJ1MjmjguprLJto/KvnZ2GeKLwoODWAPLj4QLzFWhz965J64Tc7Ri+uRg3OW7fUpQiZ54mef60gGGkGtXauDgPifFrfG4EWHsVKmOeXwE79KCRd0J3mNOL44S2l5PHt/PIuTNZA3hpQDGo9HefhVUJnHT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9418.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(66476007)(66446008)(8936002)(66946007)(83380400001)(52536014)(66556008)(8676002)(5660300002)(76116006)(64756008)(4326008)(41300700001)(7696005)(6506007)(86362001)(33656002)(966005)(478600001)(71200400001)(316002)(9686003)(6916009)(54906003)(26005)(38100700002)(186003)(55016003)(38070700005)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?a1ZQWUg0em55eUkxUm1YM3AyS3BqV2U0MDVObGFJMGJxWnVUTkVoOEpL?=
 =?iso-2022-jp?B?WlJ4QXZuQXpudVFGdkhmMm8yUkxGYUl2K2NDeEV4dFNhL3RMYldXa1I4?=
 =?iso-2022-jp?B?cW9pUU11U1d0YmZna3E4MEJySHZkaEZPNlVYTC9PaDc3NFRNb1NHeDJ6?=
 =?iso-2022-jp?B?aXBud1docmNDMzQ4QzgreHhMV2pSVklWNExjbklaZWVRVkk1TG1uYStz?=
 =?iso-2022-jp?B?cUp2NTF6VWlqR2JwMStRZzVQcUNwaUM5a3BDTmtCVnVGSHRKYXNqT3Bu?=
 =?iso-2022-jp?B?Z1pKenZXWHFCSnlZc1E1TndPd3J3YTJ3TnJWV3FGbFEySTlKdUx3RHND?=
 =?iso-2022-jp?B?S2ZSWGJ1QTB6c3NYdmNpc0pWUThmaFQ5cEdGNnhEVStDM3F1STVOVG1k?=
 =?iso-2022-jp?B?UThhbDE4UU1mbXJETkJUeGhOZlp5RTZIMXBoWHp5U3k4VE5NNnJlNUZx?=
 =?iso-2022-jp?B?ellmR2pjelRFZkhDSk5PN3NvSnlGaThRT1AwbE0ybC9MYnI4VzdyaEZx?=
 =?iso-2022-jp?B?QXJlak9Celd4UDBQT1pmMkUvb3hCL1BseThJdkUzNlhxTlpPd2RJN3Bq?=
 =?iso-2022-jp?B?cFoxZm40bnVXdVJCOTMvUVJjcys1ZytjN2tRdnR4WmpiOXJVRjBRNU00?=
 =?iso-2022-jp?B?WkdzOVpHTk14WWVOUG9EYTgyR0RhSzRGN05vWFIyTUloL3VIUjNINDU0?=
 =?iso-2022-jp?B?bGpSYU91MHZqNHBsRlJBMzljRzJ1VmxlcXpVNm9FZHlTaC94VHJOQ055?=
 =?iso-2022-jp?B?OUJDWVBWenY5dXdtdmRTcTFQTGZ0NE9oUG5sSzFyLzFXV1ZYRGFMNGhm?=
 =?iso-2022-jp?B?N2dyWi9ocEFMb0R1UVRTR01qNXRMd1Vua0RNSUNlNUQrdXdxSWNhWTFH?=
 =?iso-2022-jp?B?aDZLdUJ3WGovbEdXejRZVDkwS0dNRHFXbjVTS2grM01HQ3RIMHh0d1pL?=
 =?iso-2022-jp?B?MXhsWldZWHNOVWVTSzJSNFZKZkQwemRsTDIzUUdKMnpzZ25YdDYyYkNQ?=
 =?iso-2022-jp?B?WDNzemJQK21maXplYlVsM3dtdno1OTVnT3NhVDNpSlFYb0g0Nlp6bWl0?=
 =?iso-2022-jp?B?OXZzMm9nSis2THlEYjJBUHdteHR6SmpVaU9sK29DMXhaMmNidm8xemhi?=
 =?iso-2022-jp?B?YlJncEVuL2xoWDhPVnVraHNZekFaSXU1d3BCWDFoV1V1VlptMjcwVDNZ?=
 =?iso-2022-jp?B?akp5MnJIWkpjdXBxT0tHcnFCc3pMRDlWTjhzVVhUWVMxZ29yMVVwSCs0?=
 =?iso-2022-jp?B?Zm5NU2ptQ1BwOU8rcVBzZ2FhbzJIUW8zL0ZwdEpiWk1kR1gvRjJZYTFB?=
 =?iso-2022-jp?B?WU5jNlY5MTk2WjN6UHFpeWJXWmh0THpOZWdlemVuNE5JejhCdTRPbEp4?=
 =?iso-2022-jp?B?YlpoMjQ3aGNaTkkwMkpjNGFGeGJMd2JWS3p1ZG1CaXZoWEdCdnZ3QjlD?=
 =?iso-2022-jp?B?TU9Uckpycjk0a1NwM04zRWc0ZDRETHBMTCtxWFdkaGJ0ekV6ZkpkVURv?=
 =?iso-2022-jp?B?UWFieFlFcEZ5ZUd3a2FnWXZHMkJJdkpGeVJCbkxDOTg5MmRNRDc1MXJU?=
 =?iso-2022-jp?B?OUVuTDFSMHBRd2xXUDl3RE53Y2s5TnpoelpvUzlJRlB1T3czT0k5WHRC?=
 =?iso-2022-jp?B?ZkxMNllmc1FpWjVEQUx2RCtkUEErWUtab2h2RThadW9aQlZXTHRVcWNu?=
 =?iso-2022-jp?B?eUNZOUY5Q251UGJzU2VLNURmY1VwV05uZ1ZadUswdEJLVXRLbThVYi9m?=
 =?iso-2022-jp?B?NzBwbjVONUh4Q1c2R0RMYk9GQTVYQ0c4cVYrZTNySDJRVGJZdXhxVVZX?=
 =?iso-2022-jp?B?YUxRUXZyNUtnUG00cXZNRjhxQ1NTd2x3TlZCVTJETHlTWTV6QWtZK0VN?=
 =?iso-2022-jp?B?azhRdlkwNkFxbmpzSnhYT2pNTWs0VlgzcEdVTGVCMUxKVGdTNE5iN3lt?=
 =?iso-2022-jp?B?YjdrZ1BGbHhNeHNGTmRNV2djbEh0ZTViVmFyOUhKcDV3OHpyQ1lNV3M3?=
 =?iso-2022-jp?B?WEFDdGhwU0tQVmgwWmo5QXF5bHcvd1NuR1NnVFdTQlVqSisvbU1ON0kz?=
 =?iso-2022-jp?B?UDUybnpkem1hRzE5OThua1c5eHIrMndEeXZteDFkOHlxMEJMYnZyd2tN?=
 =?iso-2022-jp?B?emF1aW1TeU80QjVya3ROajJTUHpNS1luOEpvUXZzSTdTaHJZZ2g2T1Bz?=
 =?iso-2022-jp?B?MEh5RmRyOTFtMFhFYW9zMStRbTkyZFhpWGRtMU93amx6RmRnY3VtVFB0?=
 =?iso-2022-jp?B?d2FteWg5MTl4OEFQWnBLa1luSHNrWG5iU3BteEF0VVVpZ2d0L2Q4Y0xL?=
 =?iso-2022-jp?B?ekVMOGQyaXJaY05qUFRFZzVKMFlGQm9zakE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9418.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d05e56b-4d06-401f-6e61-08dada42455d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 00:05:39.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38izqZXIEoKr3ZOG6nJ/Nb5PJb+WIxUj1migtRey+tlwRq/zPvhXks5YdNiL3k9LN9ZwjTeOMZU6TzW8BMw2nyqZrG5FUibFtMnA809HLsn117gz9XKhEOtuhvlVPjqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9639
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 00:06:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10177

Hi all,

CIP kernel team has released Linux kernel v4.19.268-cip87 and v5.10.158-cip=
22.
The linux-4.19.y-cip tree has been updated base version from v4.19.266 to
v4.19.268, and the linux-5.10.y-cip tree has been updated base version from
v5.10.155 to v5.10.158.

You can get this release via the git tree at:

  v4.19.268-cip87:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      268e570d0a5691ceb479fa0368a6c73c5b080f89
    Fixed CVEs:
      CVE-2022-3521: kcm: avoid potential race in kcm_tx_work
      CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().
      CVE-2022-4378: Linux kernel stack-based buffer overflow
      CVE-2022-42896: Bluetooth: L2CAP: Fix accepting connection request fo=
r invalid SPSM
    added commits:
      CIP: Bump version suffix to -cip87 after merge from stable

  v5.10.158-cip22:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      f37e570b7c4ab8bcfacf36780a9e204878f2c181
    Fixed CVEs:
      CVE-2022-3521: kcm: avoid potential race in kcm_tx_work
      CVE-2022-3169: Request to NVME_IOCTL_RESET and NVME_IOCTL_SUBSYS_RESE=
T may cause a DOS
      CVE-2022-4139: drm/i915: fix TLB invalidation for Gen12 video and com=
pute engines
      CVE-2022-4378: Linux kernel stack-based buffer overflow
      CVE-2022-3435: ipv4: Handle attempt to delete multipath route when fi=
b_info contains an nh reference
    added commits:
      CIP: Bump version suffix to -cip22 after merge from stable

Best regards,
   Nobuhiro


