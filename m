Return-Path: <SRS0=jh8e=G3=lists.cip-project.org=bounce+64572+6136+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A80C433E0
	for <cip-dev@archiver.kernel.org>; Sun, 24 Jan 2021 23:19:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7F4229C6
	for <cip-dev@archiver.kernel.org>; Sun, 24 Jan 2021 23:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7F4229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6136+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Fm4XYY4521723xXx4Eq8zgGK; Sun, 24 Jan 2021 15:18:58 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.29034.1611530336451179632
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Jan 2021 15:18:57 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 10ONIXD7032668; Mon, 25 Jan 2021 08:18:33 +0900
X-Iguazu-Qid: 34tMScsDAL5EcXx9QV
X-Iguazu-QSIG: v=2; s=0; t=1611530312; q=34tMScsDAL5EcXx9QV; m=vuqc1kNYiWQfsVrQ6IWFhGU9D3keymemMHRz9qdHTDI=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 10ONIUFa018231;
	Mon, 25 Jan 2021 08:18:31 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 10ONIU6k014990;
	Mon, 25 Jan 2021 08:18:30 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 10ONIUmS026515;
	Mon, 25 Jan 2021 08:18:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhSRbZCbZBLPK3DjnM1dKuioQaD98J3sFMsbkHz1HxrIAGnKwB1H185kG+EXEvhpn2V64dR0yFgSdTBpIkaJ0/cRzs4an3Xbl/K8b173z2D1ULHUiwj8z3+iJRfj3xwWV35hOtZQO7AQSFvtZpv9QbxB9aPaU2jz2VpvMV7/ZiWohpLjeR5nTnFFvP7nf0P2x/qUn20me9eLahPEWfssWi0JxsLVK+gs8aq2/JIQ1GxRRtQcPrzyKvEUp0mnmCAfBU8gyLGODOsb/HbxCNXYdjE1r5Be75OyZnkeEm4N6uFv2Kz5AigtMldtE6VLNaFZXD8LfRBSXB59CWjL2hda6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PyHPOoZuf+bZllHK+HTGyxjMyIoDmb43LME/nF+qvI=;
 b=SSAm9zirmHnyid4m2CHV0hS8W/SZr51EV8c4UgHQr3ZptCPXG+KuQ3uH96HveUeCL5+z2J9MzNc+SWjCDIGywP42vt6zAgKy74RSy/vPme8W8SaLcyLDNzq5wf3/APkwjovOF0zscYF91jRcDuzF1b7C8K3B34saFayvJixxbza8b5QqQV7mwH5D6PpPLPtDSY+ag1l0u/uvYUeNRINJoZS3J5kiiQ0ZcMaZHDTK67nN1d5lLVCuvgyqCEEMhe8N5fRNANhManR2BeRyt6ChsfW7O1IE2I9KGKOK91owsG4UzWMk6UqKlet3e0Uf08NB1D4/R7OKUKNzCWxvMd76Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <Chris.Paterson2@renesas.com>, <pavel@denx.de>,
        <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.169-cip42
Thread-Topic: [ANNOUNCE] Release v4.19.169-cip42
Thread-Index: AdbypzXoBU4KV1SZToOTQJp78BWqXg==
Date: Sun, 24 Jan 2021 23:18:25 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29839D8F64D31E16D7CA1D3592BE0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab2b80c6-9aa6-4c0c-cf94-08d8c0be59fa
x-ms-traffictypediagnostic: OSBPR01MB3430:
x-microsoft-antispam-prvs: <OSBPR01MB3430C864D8C9B6C4B7A76D4692BE0@OSBPR01MB3430.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r9j31SFrazSWHEGvd5yKjhDU/sMcLxUwSCi4XcPMp1p3PEzr8N2OaQxmY6xsU7kTFGFlNMsoMK4AzTdENS9zS9H+ogmCOmXYhh33V9qsxj1ONlpZ5YCe+sCVgrvh/ihcNAOKu+8pLeeTrawJaIAASonkA4jr2asUJg49Fn/Cinhe1taEbQm8iQ5PHZoICgdvSO6RNE7wQmw8Ddt2rGrZMAB3HqZzRHqHbrUU4ayxVbAymrjuLO2WhJ+pMmK4tEShwueNkC/dgUCNyPcko4kslqq3MXQ5NtC4D30W8BLJft/PhzuqP+jXcKZ9KCp5gp5qpiTpT9OOc7Jx80mKhq18nfH786/QtfD8lWdXl/5+8EnLcRnqlRW/TsVWQSgoj8aUpVsuGBt/trQtu2dpUSyPrWbwv4B6tEMGJorvbCK92yv1t0ED3tmf28b2IXWN0AsP+rvMq/gNb238ERTXFUaE9w==
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTFhWGZaSTJwRUFKbHJ3b3d4ZjdVYitabTJWd3JjVzZodEliQ3YvWjkrRjB1?=
 =?utf-8?B?d25SZmhBRjVJcGlKTk5iMG8yRzBxZXV5dmk5L0RlRTNnV1BLZjNnMmNmT0J1?=
 =?utf-8?B?Vko0Wk5zK2hFVEFFMXVVbUhMMENnZlN0MHFDQ1E3TC9uZkRKSDlHZjR6TkdS?=
 =?utf-8?B?Mktic2xqZElpR3d1VkhCMktWUy8zc3Q5RkNPclRuc0tYbFllUEhkOFNWaHEz?=
 =?utf-8?B?eXF0MjJ1dTVGZ1ZLQklUbkduOUpDdkRvaHhDaG5yb05ZRC9Kb3hqbWI3MXYw?=
 =?utf-8?B?MndzZjByTG91eFFRS1lLMXB3L2lLTVcyZGRkYm1aVTVPRE9tcm5DR1hTb0Uy?=
 =?utf-8?B?cGdwTTUvd1BvUTd6NUNISVR3cTVoeTBzbElYQlk3eVJrOW84ZnR6QVJhSUJh?=
 =?utf-8?B?cnBpdk0xNVU3aklTbXBRRHdnbEpnZ2FBbWFsZThxcC93UTJYWnExYW9qUzhH?=
 =?utf-8?B?eFdJK1pvYlY3cmtZcTF4R2NWdGc3dVFNM25QRnFDdVRmMTRMMDhvYkNqRkt4?=
 =?utf-8?B?anE1WTUvMGRjVEZVOHRsN2k3YUhDOENHeEdYWVJHblFGUnhnOWRLTHJ3c1FN?=
 =?utf-8?B?R29lS2JHTnprbW5WeWY5M2EydGkrL2RPYXF2RFdkeVJaZXV0ZXAxRTlpTHBy?=
 =?utf-8?B?L2JEbHVCM3lyYms4Tll2a25xdmxNbGZkVDIvNWxRYXBJT05IWXd1MGFKcWZN?=
 =?utf-8?B?ZzNBQzZhaW5DTGpLUG9QMkJtSUM3NlJMQklwZWdpdU4rRXhSNld3d2xtMzhU?=
 =?utf-8?B?M3RUZXVlZzZIcFBYNUZmcDU1ZjdRaWxiWExIQ3MwSE1GQ2ZTK3lGU0dVSTBM?=
 =?utf-8?B?UElOOVpiY242cXBmSC9NS2VvdFdIc3BvY0kzdE4yWWFkQmViMTVuNTQvUHQv?=
 =?utf-8?B?NnFYYTFOUzlDU1phWjNId2JFakg0dlFyRVV4dGZOWGhjd3RKeTNoRkMrZGtS?=
 =?utf-8?B?eURFTmdSYjNKbTNxd3E1TVJDYVhZRFc1TmRSbFBiN2dyMkdmSlRxaUZsZXBW?=
 =?utf-8?B?QXZJSFkrUU5XaVMxTmJLNkFITXVSZW9HMEExaGlIOEpBaTZnK0NVRGJHeCto?=
 =?utf-8?B?SEw0aXlEanN5dFdsSG1tWE1CczV5OUkrNkZKWWd1VmJUUzBNWkZkYUhXYUUv?=
 =?utf-8?B?YWZjVVpLNmVQanp5Vnd5bUtSY2ZLM1RtOFN5OUxTc0syeGtXSzYvQVV2UWtq?=
 =?utf-8?B?bm16Wmt5SkNYL1BTV3VHZHdyUFd5TnR4YXkrbTlZV0Uvb2F0elE0ejFlaFl3?=
 =?utf-8?B?aTNuZ0ZJR0VTNXp0bzg3THd6Z3NZcE1tazJtdEI5akFzVWRyVVVGMVhHbU1H?=
 =?utf-8?B?NkM2SGtreFl4UVgvQ25DZGg5d21QUDA5aGdkeEM1ZEUxQVIyb2loL1p5OWNU?=
 =?utf-8?B?ZWZ1dldaN3l0ck82L2M2Q1NlM1FZSW1hTWFlQXFFeWhKVXBnZGE4SFlGZmUr?=
 =?utf-8?Q?lbieJMsK?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2b80c6-9aa6-4c0c-cf94-08d8c0be59fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2021 23:18:25.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBu93VJE/2YER64eOtP/uuyQCaELpyD8Pk0oDFGBNyj7K9RUf8UtODzJi/IZAknUDFFjRyHLjRJ5hp+/z4ZKb3Ay/YOEIOd1LVqlKc0evsby8SCIgXozcRUrL6afZf6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3430
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 65qkD6qDRdXTFlUIIadk4T4dx4520388AA=
Content-Type: multipart/mixed; boundary="XZV1bU7XuY7BuqrbB0Un"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611530338;
 bh=UCsxqbFlijK2sjxIuyveWYhmo+3iZDcdgpgMqHNts64=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=l/OPBP8UfGt40FdFCqPuBduYfGRwnIa4qaRD4NdPqNgjojXf2j8aVy8Q+gRqIIzGbHb
 4wVHWuk4rFppY7rqwxLzigGxn+NkZCWTXghXas/L9DqK+TRuzQzxdcl7F+KOuuKnTxd/N
 nDNWZ4uI3rSZt8VP24arS34FIlmnCulYaqk=

--XZV1bU7XuY7BuqrbB0Un
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE2
OS1jaXA0Mi4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xNjUNCnRvIHY0LjE5LjE2OS4NCg0KWW91IGNhbiBnZXQgdGhp
cyByZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTY5LWNpcDQyOg0KICAg
IHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQu
MTkueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIDU5NjkwOGY3ZWFmMDVhZWM5ZWMyNjlk
ZDFjZjIzY2ZjYmRlOTk2ZWUNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZl
cnNpb24gc3VmZml4IHRvIC1jaXA0MiBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpCZXN0IHJl
Z2FyZHMsDQogICBOb2J1aGlybw0K

--XZV1bU7XuY7BuqrbB0Un
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6136): https://lists.cip-project.org/g/cip-dev/message=
/6136
Mute This Topic: https://lists.cip-project.org/mt/80091425/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XZV1bU7XuY7BuqrbB0Un--
