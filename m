Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C85CD343F
	for <webhook@archiver.kernel.org>; Sat, 16 May 2026 00:49:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48060.1778892540208525417
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 May 2026 17:49:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=IOdeC8En;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1778892523;x=1780102123;bh=
	pzbQ0nj+obx2oo6v4F4RcQV9070txW0UCzcl1yhGap4=;b=IOdeC8EngY2gzc73gHL3UPLBHSxMEF
	baiygJ6pyEOvyec6TDH5edj00FnzxygfX93/LQZWMpZX837LMSL/yWvWJjBAhMGvvYxZNg1Pt5yFf
	u52973lSJCzWlvTX86TG1soi0VjG+PwHZIZFm1naQNmt8uZXIHajNTMgAzZLt/t9qRfYH25GY296B
	WHFXuxIxwjnAWPAZAV06NANLYvD6j6pGxJvq6R64UjDVW4Tx1BpczgaqunLBM/PJcg+2lDtgcXVmG
	BfVxYlRRaFno6YyMhdHJ02bed6SDHZJzK3DbO7KZ5sj4yjyMpRgvABEF2HWvS/5i3mIV9pS9RZJR1
	sjOA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 64G0mg511974088; Sat, 16 May 2026 09:48:42 +0900
X-Iguazu-Qid: 2yAaCpG4aQBlmiokFt
X-Iguazu-QSIG: v=2; s=0; t=1778892521; q=2yAaCpG4aQBlmiokFt; m=OXMIkQPqKhypAUVrX/h7Q67RftQMG/qxuFZHSerWvNA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gHQRX6wBKzyPZ; Sat, 16 May 2026 09:48:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdTXrT/U/QV6oV4oX8OaFNymvtwpiiJzW6z8JYMUZ0fh6fqmlTl2tmC7C6IkeOByLAWdfBSXsCzjb+UM221q+7f4EsGozPMgzjDngfXZchCxjMh9b5o7bIN/QRrin2LyO+yZ+Zusdcsuioe9ENIFNnfwLpzJQYZVskohWiEAMBziB2vvGv2lKWD7EAkTujcEc6/+ol45jzkqwB5WyoVxLaXQPGg3IPvSrQclcoF1qm5Rg47sJRLqB0ZcJZx23cykjoufYseWx3umWGJH705z8BbbZYj55HCadeuUmaCQlmTl2mwMQbIvfIrcTOCO9QHNy2waG83qB5OI0aVoElULBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUyxTNN+wdKEKv0JKQxG6AD8BCWoUAoU3OZMTFICMBE=;
 b=NaFetAqJ7q7VJc7uOjAYvq7NEeqvcNdALOUcapJ2w0ocikRbEMai9jDBLh5pt+vltptK1UlINtmxSIT5MtsM7N2T3Lw4RMihlAPM9B+4RZWAnmYUSbS4+p1bcZAI5KKf2wf9/KXOL872JSOORFS8y1ShBLwNVB+tRdKsE7IwvRdTcaCiOOB5DzoHK21n2pGEtZprxNa8PSOOSNZNn2Tx0Tkff+BIH6W7kiCFHtfPP353nJNS5DnW4o7eVTWsXxr5WY7kGgF8eJMXyGXuGx0QjaW3066lrigjiCu0ezp1LldubSN1jHcoc6NqKn7Ym6PPDfKGyAr9d2fcYXnC8FQVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.173-cip56
Thread-Topic: [ANNOUNCE] Release v6.1.173-cip56
Thread-Index: AdzkzZLar29Y5hDqS3K+fUOBneFxvg==
Date: Sat, 16 May 2026 00:48:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181CCBD3460DB93968D6BACD052@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB12745:EE_
x-ms-office365-filtering-correlation-id: 45f83c71-272a-47b3-3bed-08deb2e4dd93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 VJc6LpHqatQ7IdV8bUFaCaipzedNvzIiokH974IJK9V9ADEzD11JC9if9mZxYBlQHYZ2cOINej51vffIYQnwYsnVFovzVlwxPXIxg6Rqy5WhV+mHHb8RwJwr1ji6xcxijv3BCcPotNqWTZ8Nz5sMWOvBBsM6oFhESIfbNQKWm8Mv7Vg6QgAAJerXZmw7hBM3CV1YgYY/6kpsxT+TSTfus9kDE3Aj5AZFnIcLa5j2PbjDGXRHGBu1iM3Qc+oo20bhaG/w3pmZRR+S9E2bkoj8KIjj67d+XPxCpeIwVCdEFnktYO+HqDFu0vPcj8ysPO78nD4kOYm46YOLCPXVnZ7MzSHh+6jcGNK9MPbZBqwlyuIKeA/SdVL+uLOUzityzUsZ7o9WNX7Ws9oqzy4EkQtD2bzWLWHsW5yf4smm4LBe0AlbVIFlS86bMvJiPL+vKRw4f3iHx9JI36/NJhn7q49Sk/dT5Vf7k7MOTjKfMayZK+N1HmaYHMSVVvqzMSxxhLqm4sBjO6o8A1SuUUm7iTNH4gufBx4TDlQxPcXZWT/EZfk2DLhmBN/Yjrxob5qtbxTKovAOqNipZJKSR+mG7A+i0DNmS2v6YWYgpw2Qq/HfvbehOnV6rYytNeihos3I+SM6lcBn5S1qHospn9pOVmMybaC55msoCekLomfmQokQjKXEMqz5vxufcmXnWKcbtwaOIaBBjfgb5s//etld5DRveUf5qEQ1llsa1NEeHD8motUx161kqVKj/5PZDN2R+jOl
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cXhsQ1ZYNlFjZVhKZTFqWEJQZVZQckZTK3pxd0VnOU9obkt0WWFNRVFB?=
 =?iso-2022-jp?B?Nmp5T3BocDFsVCthbWs4eTNLVCt6YkNnME54VSt1bGlza2hQRUtWU2M2?=
 =?iso-2022-jp?B?bDRUWm1UdE0wTEl3UWhDaEd0M0RHaWI4OVA2V0VEdWRHRUowMCtueWln?=
 =?iso-2022-jp?B?OUNtQndyYTZZQWtMZmlaTVI3OUFhTXpTcENVb2c3OTlpRTBSOVNKS1Rl?=
 =?iso-2022-jp?B?Z1FJRFlxQnhuakE5WUE4VjIweWgzaDdKZGlkRjVhSVdQdGtFUWdVcGVh?=
 =?iso-2022-jp?B?aERGeFR1ZllGcGwxL25HNmU0VzN1WmhFeUVEdVVaTnBiVVE1TnlQRDlD?=
 =?iso-2022-jp?B?dUlMYVVWRGlHRnMyalZRc2RQSy85akIydnhUOWJvZ2FTWEZxK041dmsr?=
 =?iso-2022-jp?B?TGlQWEdCUlBNdUtuVE9uNC9NSHB1TEZoZDZHSUZPajZLZlU5WGlpVXNk?=
 =?iso-2022-jp?B?MWV1YlowaHVDSTFLT01hRXpYVFFYQXBwcU9EelF5dURvZzVlWG93UjB4?=
 =?iso-2022-jp?B?eTNvSXZzR2FEazVYM0ExblRlN1hBeHk5NzBuZWZOWkhMSGgrSFA5Rml2?=
 =?iso-2022-jp?B?ZFVPOFpYc0d0ZXJiSGhuN2RmUWNIWUdVWmJkaTJ0Q1YwVE11VTU5Tndm?=
 =?iso-2022-jp?B?Q1NMdkEvL2ZSNVFsbG5wZFlodlpjNlQ2bllCa2VwNmlXUkpIblAwdFpu?=
 =?iso-2022-jp?B?Y3l2WFk1TjJjbHlRdU1zbDV6RFdWaHhUVU42YW9zUUJPalR6S1plVjhO?=
 =?iso-2022-jp?B?cTc3M0l4N0t4MElDOVVlYndpZlZvMDBhUjVxWHBTb21EandKOUo4YTVN?=
 =?iso-2022-jp?B?MVlBbm5RWHVOZVJmWlkxY0N3S05oZFZCV2FxMEtzS2U2VXhGbnE3VUh3?=
 =?iso-2022-jp?B?ZjZHZy9PbHBCbGVocVRBR3RFUGFRZ09oSUdrOWpmR05qSGVIcERFdVND?=
 =?iso-2022-jp?B?bHMrc24yN29wM29Ya2JLYy9PbnEybUFmWnNkUEJEUFF6amtFM1gxNlRy?=
 =?iso-2022-jp?B?TTdhWi9pQ25uUEh4L1poYUFqdXpCa1luM0xHdm9LSWQvY3lxaW1ZK2dP?=
 =?iso-2022-jp?B?UERhbDBoUklZQUFYcTVJQk9IeWlBYzR1dTZyTzYrVkx5eWlvamIvVkJn?=
 =?iso-2022-jp?B?bHNQdjJXRGJQM2VEU29YUmdLSS94SHE0RVg0SW15d3RLSnIwaVRKNStV?=
 =?iso-2022-jp?B?aExBNmp5R3B6QXExOHl3WkNSQm1mR2J1emRGcUxjWTQ2bS9uSXpPcEV0?=
 =?iso-2022-jp?B?NmpkOVJIRTFPNVFqbEh5TGttc0hkUmVzZ201ZmZtWkZTdFVCUkxFNDRB?=
 =?iso-2022-jp?B?YnBmb1dqc0RLMUxEbXc5eGdUTXhic21FVWZOQnUyUEkyeERTT24wdXVQ?=
 =?iso-2022-jp?B?eHdMSXlWb2ZJSEo0c28yUi81QStrR01FT2NiK3UxSnE3TXg4Y0ZwZG82?=
 =?iso-2022-jp?B?czhHNlE0Ykx5WGJyeXdKc3RUdDc3SElMOVRDc09GMXlKa1paUUIxdnhv?=
 =?iso-2022-jp?B?NDlLVi9nakF3OEo3bjRpa2s2eTdnUTFWdWk4MUFQcmZHSElsQ3R0VlFV?=
 =?iso-2022-jp?B?TFhxMURicTZhNE5rRktaOTI3YUFtTHNiMzVZT1QxYXdHb1FaNmdBUEgv?=
 =?iso-2022-jp?B?NGsrNURSenkvb01IZVdoN3VGVThSR3VyL1FlaW5RRjNHcDJzNzBtVUtu?=
 =?iso-2022-jp?B?am1wZGNramkrYVRScEd2dW5LeGhpYWF6YUwyeU1BTzBBK0xiTFJjcGxy?=
 =?iso-2022-jp?B?MWU3bXNHbk5VNHF3NUErSGFJMFBrUWMwNjZHWjdvZFhuM0M2dE8vN0hE?=
 =?iso-2022-jp?B?MUlQSnNibU9aZ1pzL0dpcjJMcTJ4ZlJDb3dZSk1GUWswaElWOXAxbE5z?=
 =?iso-2022-jp?B?SjJrQld0bE01THJ2aDF4K3JNaTRJaGJvYkd6TzlrbVZQWEdza1JucTA0?=
 =?iso-2022-jp?B?UVE5K20reEpoQUZ2bHY2WkNFTCttQUlueXk3eCtmTXF3SzZYZElMbDhQ?=
 =?iso-2022-jp?B?UG1IVW9wSWdPZGN0b2lOM0hmZVRFbGNIWW45S1J2OGozMmJZWGlONllx?=
 =?iso-2022-jp?B?TmlVdU5NQjUyMTVRNjNjbTlMRFRuM2dSbU5nWlJXbzhNb1NUaXVmV0xi?=
 =?iso-2022-jp?B?ajFXK2ZrOFhtcUpVTFJYcUVxRTlaOUdHOTVvekhCTHdBVTREMnZ4YUhR?=
 =?iso-2022-jp?B?R0ZPbFBXTkNKcGdpcnJmM2dmVlE1WlZHTlNET3ZPS2RoSm42L0hGWXg3?=
 =?iso-2022-jp?B?eGI5Mk82NlM4R1RKeTI1ZW5HMUY4YjczbWZMbzdBVThsMDFJWGFpcG51?=
 =?iso-2022-jp?B?MlBUTXpIc3o2Y29jTWxGbnhkM3dlUkk2TzE1b21ZWGJNamp2RGdmMWxw?=
 =?iso-2022-jp?B?VUhKQ21CSXlKcnhOdDBtRXdmcUhDbngrckVsb1diTks2VzhXb2pmME0x?=
 =?iso-2022-jp?B?MnE4TzR4QUQrMThBNTdML1JSbExrOSsvb0YwOG5TbFFpcHl3WThxV1pL?=
 =?iso-2022-jp?B?SEVVWGR1bXhDRzlsSE94NDh6bWJ0R0FVeXArNXhPakVGMDI3SXhyaG0y?=
 =?iso-2022-jp?B?Ylg1Y3dwRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Y7LCNPkWjXYci22cZOAcEerfzHtnYZQCo4p5Dg1USX+fWhi6w+dqlTqbkTo9R60BZdWN7+xICV7ZWAohIwuh+KF/pyEnXZ87ROAsd+qI3823wWGeujPRMZK1l0CsZpbpvnE9K67m9pobL6RbTY2COvBSitehSm2gtC/NfqIUxfbXAb4+hCEYKAsHMSUwDdB1zCl5d32O8rlq5Y/UmCKCFV1R7+jx0EnpcXMx0oPH/m4YjSczsZtLYiN93dhDUujYAIjbkNM7SJfpNBJBy8cTh0XMpTP6Q+oTo9DAVTPYrYOKs0TwCldvSps51qPZKk0R2qaLtLKYbXetau3K9rd7MA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f83c71-272a-47b3-3bed-08deb2e4dd93
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2026 00:48:37.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYWsE8Y7pChPzGkjFVrql3vLYPtMO+ZvbnRy5elCYhQrtPsGCK5V05AmK0ctBmgTS98ZW+HIj4sQqC8T4nzARgtVjj8V7fNMVT6jER0cesrcHHMR8sSzK7Gsmw+AiauB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12745
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 May 2026 00:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22971

Hi all,

CIP kernel team has released Linux kernel v6.1.173-cip56.
The linux-6.1.y-cip tree has been updated base version from v6.1.170 to v6.=
1.173.
This is based on the LTS release that includes fixes for Dirty Frag (CVE-20=
26-43284).
In addition, the CIP kernel includes update patches for USB 3.0 on Renesas =
ARM64 SoCs.

Information about this release is as follows:

  v6.1.173-cip56:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      73835a6169657d71475c528d5808f05975fc81c0
    fixed CVEs:
      CVE-2026-43284: xfrm: esp: avoid in-place decrypt on shared skb frags
    added commits:
      CIP: Bump version suffix to -cip56 after merge from stable
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB3.0 PHY and xH=
CI controller
      arm64: dts: renesas: r9a09g056: Add USB3 PHY/Host nodes
      clk: renesas: r9a09g056: Add USB3.0 clocks/resets
      dt-bindings: clock: renesas,r9a09g056-cpg: Add USB3.0 core clocks
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB3.0 PHYs and x=
HCI controllers
      arm64: dts: renesas: r9a09g057: Add USB3 PHY/Host nodes
      dt-bindings: phy: renesas,rzg3e-usb3-phy: Add RZ/V2H(P) and RZ/V2N su=
pport
      dt-bindings: clock: renesas,r9a09g057-cpg: Add USB3.0 core clocks
      clk: renesas: r9a09g057: Add USB3.0 clocks/resets

Best regards,
  Nobuhiro


