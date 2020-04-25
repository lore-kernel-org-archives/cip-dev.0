Return-Path: <SRS0=Nx6S=6J=lists.cip-project.org=bounce+64572+4599+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E820C2BA1A
	for <cip-dev@archiver.kernel.org>; Sat, 25 Apr 2020 00:28:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B9E20776
	for <cip-dev@archiver.kernel.org>; Sat, 25 Apr 2020 00:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZciB/mMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B9E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4599+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cqnqYY4521723xIXGhJPJHYy; Fri, 24 Apr 2020 17:28:39 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.281.1587774516573263517
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Apr 2020 17:28:38 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 03P0SCUO031788; Sat, 25 Apr 2020 09:28:12 +0900
X-Iguazu-Qid: 34trWq5awljdd70COo
X-Iguazu-QSIG: v=2; s=0; t=1587774491; q=34trWq5awljdd70COo; m=XNx8/YBB2M6nsoPj0aWeUa4ViaKvEXj/1WVd3PS17js=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 03P0S9jY009786;
	Sat, 25 Apr 2020 09:28:10 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 03P0S8es006183;
	Sat, 25 Apr 2020 09:28:08 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 03P0S8jm025977;
	Sat, 25 Apr 2020 09:28:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jy+Dj6y+01lqT4m0AlZIn7LNv3ms2/ONBuoxrDM5B73+N/pVce2/xfyqmpoQv0R98jOYYOH/JY3a83OPeT6gsLeW/aUPY5uoGaGxOeeKzDUeZdHKc2Fu6Ax5FtiUKw3TKXesqwzvcnagm82twMa9GMAWdKX2XdBtWCpvJKEl9OGdgsDLQTrtcysMc8I43/sx5WmQ+qhqW7ebHPtTJ1go5O26F5iy5bD+lyn+Srceh51ib7nCTRlfid8RDtFfhHFiSSiZc8jzT6hr+norf+NgnSEQ5/CARRMXM3lcjso72OjExis3Sha/LWx3D20t10qlyFxWdsvsVwC4PzbfZQVYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDzCzqwzBcT3xdMajfw24gteIxLB56u9zeLJ+sjOtQo=;
 b=Mg/KDZSkMaDsDrbv3m0lvzQvscNLeS0bhoXA08u8jKwptufntNw96FMddm+hPCJrS2W3ovcE4abGIkQfnnShdw3jRui4Dlud0ah+B36XyJ/Iu8xnQE482/Lqi8qqRXeqFfK0fCpyZcTPtXIkL7zTUTd95//5xecy62XnhMuQ2IZlRcyal9amFqannoS4ZEYUMsv8wWSS8v59qgLz0CWrT/JaV7rmKx7CTN6PEuwu0X39jzZhnnPKuY6va/V90j4Lz11hbP4LpEa9BXxSLgi88W/mdQza/X1hSSGZhCjZueBPxcdXYRKMLaNY+8fMDEdaJhbVYlqbogUA+bSf1kl8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>,
        <pavel@denx.de>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.118-cip25
Thread-Topic: [ANNOUNCE] Release v4.19.118-cip25
Thread-Index: AdYal2/EjdPAYk/2SeuH8MWq2OTmNw==
Date: Sat, 25 Apr 2020 00:28:05 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667C1E5AF1B7ADFA8E7C10392D10@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b8b40d7-d3de-47a6-8b83-08d7e8af85c0
x-ms-traffictypediagnostic: OSAPR01MB2482:
x-microsoft-antispam-prvs: <OSAPR01MB2482AFAF3B8DFE4D05C0D5D092D10@OSAPR01MB2482.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d9FPXxPAeFlr2iCl0GpOhvcX8rFSLmw6zM8bcXfhZnG4J/tXwbEGAMX/NlTzh6XCFVnXBzxI0Ctaamzp6VJOgKrYl1rXfHeuT5pP7jSsiW139VZOVEx2LMlz7OpFzDI1hFywuj2EFt+kUpFn2C5EwcQzqOhb4W/kz3UxrLi3RwRjAvwtH9/ZlF2s3zRtZcRJ0sB/+X7N9A/WoAA12wBYEJCuP8vQVgssAmLwIXXWRYDvILgGJeMpujhUXR5LE39hNG3MEIJkA3HUn/fbUSZ/Hyg/ERdTYX3+kZL+CD4ibX09dVHr1bUA/Dz7dx4lAtRkE3t8INtvtDduVJkHus8OgKFF832SOD7itDYPP0ZJK4sqWvR6WCg93XiEaI//8R9WIHEPCjcijrWIKnY6Yt/aEz53sIp97I98hA1ynL/KVtLth18Fap1r/hFRL/LB+ZNcuxgLEzQ26OLLIlydGJNwFith4rmhkESokg2S84GOhkkxPW7NcO1tyAxAVPcJ6VjFF22DNlFhKwzpaDSNe5r97g==
x-ms-exchange-antispam-messagedata: z5sYCK4M5kLZ8DnUmltevmu1w/N8i0gNISKF+ZTTqAeT+oBgX4E4NppiqxB2bK3+nNHx33DQ3csQBF/1w3SGDJpZfwj51vulBJgt+1lsbu6/1lxIjRc1alJOTQMxuGOSFpKUJ34Vu6cP8h3mcOUnlWbM1K+qJhYm21Vm8SUR4fWCPhCtLSKTIjK5LNPOYSJ11jsqKDd9KlTm9BZkbsnzNtkXCl+H/gIOevEamkJmBvXLsffyfr/4wgChk+xsd/Hy467WjN77w78LqipT8NsRi3RNW2rWY3Kx9fy87aABL5OU0LsgNIdJvRBl+xgr7bV5H535NVB/swcos5EZeJQFPNp7zYCe2JCZD9MzDuKqVPBn8PEBbxO9mg2DMDNQUY9f+cGYrRRVkgVGFv62ybxkDOpwcMtTB2Kdj0ZiN5sPQy3hhFnfQC2EmLeuHE7AygFsWJ+xirGOKol0p+NB20HDvUC268ZzNRpos7eGGT/AX/YgbRKXjKoevsLhGtg2TaY5R0Ds45cB9FqYAcUaZqnspIKJcBTS1jML0OjM2kMfExUeocoQY2zkaCk9HnszRPCaAmzQ98n/iXZbpdtCsHermXpzMjd6swO9GSA5evefpm6dMKHqoakiyZZ3YQH0Vxf/wDfcAjbnp/p1llezLYJyRIaH+5Af3aKlqPbsDnAIcbQWir1LQfWVE6d+94REtPbveaY4Ej05g83cJ7abP9svT05g+KP8jRg/3GHjKpPtLEeaHhqdOKwChETa88330vXHmPSQhO0Zucje3SE4IRH8k8GOjHbU2bNP6JsBXlj7+mXJtTQz8zEtK/e5sCYF82+K
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8b40d7-d3de-47a6-8b83-08d7e8af85c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2020 00:28:05.5914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EbD33zjwcjtax1l7qDZ258MJRicl5WkEQ23iYZSCaUMygViUGwbujTFXxhI2LxMbj6u/OOrwN7JvwLEn1/Bqkq+Cqjdgsu7ludYwLUg45re1V8EVx/HjS8y/I3rMaeh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2482
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FA5B5jjjevqcx6yhlqxe8X0Sx4520388AA=
Content-Type: multipart/mixed; boundary="0XQJl0xyyDT1jvHZsS7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587774519;
 bh=FAyCGYOMxIwmPrnQZDoaBfYzQrpOj6LyWNx64byoqjI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZciB/mMy0dzOI7cfc2WBPGAW+8Vwr72pDIkAJ6yDv9h2KCXcvXL/mn+ckm3QFWov2vS
 uFCnvzTOQbyIcwI/MGFit/JowLUp79vzjOEtcg7QjR9f1oeRJoai6tNBgb5LzO28VJMI3
 CYwT5f9NEwJlqZU31a5jCj0Gz0ScNKjPCCQ=

--0XQJl0xyyDT1jvHZsS7K
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xMTgtY2lwMjUuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQg
YmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTE0IHRvIHY0LjE5LjExOC4NCkFuZCBzdXBwb3J0IGZv
ciBIaUhvcGUgUlovRzJNIGJvYXJkJ3MgaWRrLTExMTB3ciBkaXNwbGF5IGhhcyBiZWVuIGFkZGVk
Lg0KDQpZb3UgY2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCg0KICB2
NC4xOS4xMTgtY2lwMjU6DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJh
bmNoOg0KICAgICAgbGludXgtNC4xOS55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgNzM4
OWU5ZTFkOGZjMWUwYTQ1NmE1Y2Y4ZmUzMzZjNzgzODhkMTA4Yw0KICAgIGFkZGVkIGNvbW1pdHM6
DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDI1IGFmdGVyIG1lcmdlIGZy
b20gc3RhYmxlDQogICAgICBhcm02NDogZHRzOiByZW5lc2FzOiBBZGQgSGlIb3BlIFJaL0cyTSBi
b2FyZCB3aXRoIGlkay0xMTEwd3IgZGlzcGxheQ0KICAgICAgZHQtYmluZGluZ3M6IGRpc3BsYXk6
IEFkZCBpZGstMTExMHdyIGJpbmRpbmcNCg0KQmVzdCByZWdhcmRzLA0KICAgTm9idWhpcm8NCg==

--0XQJl0xyyDT1jvHZsS7K
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4599): https://lists.cip-project.org/g/cip-dev/message=
/4599
Mute This Topic: https://lists.cip-project.org/mt/73254600/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0XQJl0xyyDT1jvHZsS7K--
