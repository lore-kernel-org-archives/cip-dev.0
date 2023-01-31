Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C27C636D3
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 05:01:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.5789.1675141277467499530
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 21:01:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 30V51Fvd005011; Tue, 31 Jan 2023 14:01:15 +0900
X-Iguazu-Qid: 34tMMX4CATM5LO4HBS
X-Iguazu-QSIG: v=2; s=0; t=1675141274; q=34tMMX4CATM5LO4HBS; m=s5sFPYNinX/8yDkJmDNEp99CdbYdvan5nLwJo+tDtHI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 30V51DlB021837
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Jan 2023 14:01:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSssrN8+T116G8LrUF4QMu4lT5EOpqWJSRfigI9BTetFsgPfaMBnP2s1mPdenTNTrw9bGjtB39Pp+INQhl+Zb1ps9NTb7TYPkPpcThHkQmGXf2ql7rxSj6Jz9ZvUBJrenworNSt41X2q7NueFUF2lPuqsEc9VO9EUes4vqCdZJtJO6++CeYiaZEXlDmffbV7o17g6qSVhLghJK99iubuELdrIQRI2di37qpOkeH2Z/mGfeRkirYpiC60/8YSPoN0S7Bbh4+VzHtUfAPVojfnZqY+TJn0XM57rrN2UPfw+//tZVIlrXT5nOPd5iPCqKFjxMXXa1qnv12wRozfilUrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjHH0Zc+2euRoV0PnqAj/MqQpHGCPhtBchJXx186tzA=;
 b=D2Zi4EBBpB7qDDhuasMDl9sx4DCVcmLIWqfedQyeTONyNEEd6jvvZuTrAY6jeJfcRqFKxlyIP7lPYZ1217t9/YURO9HBhdsDN0JdUU39b4Ou43ICWthn1z7/nX6qq0UxjYpPi4twBcDtd8Mh/cpgEiFUVc6oZQla7OCF23biwqSIM28Ku1qZX6bMxcds+CD+SkthnVThhuPUfhQS80ijJHqJH5sE59xP08hAqSUzdvLsZNqTX+VNtOpso51SfwT8/Gjz0X9U+gPhGd5MebtY0NTmNloU/ogmOI8QOpxsKc601e6cuR44WgUi0YLWmWWOOCwGirQMOvykaMbYk8Ks5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <dinesh.kumar@toshiba-tsip.com>,
        <Venkata.Pyla@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: SWUpdate with unified-kernel using UUID in the kernel command
 line
Thread-Topic: SWUpdate with unified-kernel using UUID in the kernel command
 line
Thread-Index: AdkyGi2hbFoAUaDFTTO9C3khO1D1owDFnkeA
Date: Tue, 31 Jan 2023 05:01:11 +0000
X-TSB-HOP2: ON
Message-ID: <OS0PR01MB6147DBB5A22863BD9496E0B7C7D09@OS0PR01MB6147.jpnprd01.prod.outlook.com>
References: <OS0PR01MB61478EAC2D405DBD1F486152C7CC9@OS0PR01MB6147.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB61478EAC2D405DBD1F486152C7CC9@OS0PR01MB6147.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6147:EE_|TYCPR01MB10133:EE_
x-ms-office365-filtering-correlation-id: e4152873-a6a5-4270-12d1-08db03482c05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uM1bcQppQS7ABVd0nvA/DfZw+o5ywaoKDbZQim5iHop+LK1R98Z+kjhIBHaJkZrpHwiN8C1/QN5/fFrFAG97eil4EZlQnJcUydYSgyaTIv4QRmtvChXh6168LHP63vph8Y0/whE4ws4SEj+H2EYEXCWBiDLUD/FpFp1X+Uf/lD16YdvHAlF7WLJiFesAPoawcfgnxXeIKN7sy0M3qxkZFxDobN8jZiah2vP/pFUIVP0X+2NT1tkHOGulZBkz2rxGSGOPvTvnGRt3k/Gec+x8Pu5/TVq9HceRvyQMo2kSZaijJiGQdBkiw6X2MFhKBrasG9SzQTXt45CCWkMrPtrPSluox/DS9lQrhMKtrEbEcKSO6euZrRMZFe6BIMrwnYYZDxmyMhYewAJULHNmWKL0MVXWxrqSmQoAnnrbjsD8yth6Ev+/m5y8GVHJURLIvYrlh0ZyWWoH+p8WaVCmYreYpPFw4GUXIWkPWC8qbbgmt0KQIuCIcbaBcVCbm0tD/ZDCFKPq3N9v4Oy8ZE6xW775JUkjirwtJww/KZLMn3a9tufnqWSXHSL62ZAXiN3NKvTDuGbOsNUZpM4rl2syV9Oi7PPrRApvwVUvD2CvsNu8lzP3OA2pv5qpK3A94njIf4g6PokCLX82+m3xt9BdLJX3csVF5hbb86Jd98WiGyZ1mmTAJrOQWhoAPsNxorCwYlC+YQjWG77SpguUYH98DcskBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6147.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(186003)(7696005)(71200400001)(107886003)(41300700001)(83380400001)(9686003)(6506007)(26005)(53546011)(478600001)(54906003)(66946007)(316002)(66556008)(76116006)(122000001)(38100700002)(64756008)(66476007)(6916009)(66446008)(8676002)(4326008)(5660300002)(55016003)(2906002)(86362001)(38070700005)(33656002)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VFpqaVN5U3Jxa0krUHZjNTF0Wk1mM05wSDh6elkwL2Z0UThkcm00cldR?=
 =?iso-2022-jp?B?ZFpJZFFicERUdzJKRzFNcEhRM0tLb1dlWTVpS3FCUFhSYlBlUkdSMkZ2?=
 =?iso-2022-jp?B?cG4yalRiazU5YnNkSU4ydkdvWnpXYlNERjlmbXprZitTZmhrU2FtN0hR?=
 =?iso-2022-jp?B?Zml5d2tXbFJmY1RLZHl2TEFMdVBaOFRZNGJnRWhZUnBvcElIQzFaUWVq?=
 =?iso-2022-jp?B?YzVrTXBDSVBFWHRsRjFvdmloUm5LZSszRktqQ0FvdGFjRE5yWXRsM20x?=
 =?iso-2022-jp?B?Njd2Z3RpdFNEdUFYNWIrajF0WUpORHI5Z2tqOEFEbmVwajhrV0g4SXd0?=
 =?iso-2022-jp?B?MGxrMmgxMGQ5M2VtNFhsZER2bTNPSTdHNWNwaWdSOXZpYWc0OTdZQnQv?=
 =?iso-2022-jp?B?dnRrQm5BYnVvQlhuNmxvTEh4bDRDc0cwMUg4R044VWF6WTN3WXQ3Tzdi?=
 =?iso-2022-jp?B?OUVPT3FqaStDNFFhSTdOMW8ya3FzUDVxTzgrNWxhWkVnS3BmeEpYVVl2?=
 =?iso-2022-jp?B?TlFrcXVQYTdUc1FaRHUzeSs4WUNpN1d5UkdiTXJJV3JlMVBUcG9WSnBV?=
 =?iso-2022-jp?B?SVZBSTdNb1EwVlV0c09SYUVaa25CMDkzZG0rY0FXWk41TFhYd1l6Y0FY?=
 =?iso-2022-jp?B?eS9qRDhuaDdkbFJNVTZpNXZtV2gyeVRyQ3p4RnJkeE5RbTVvdDNxZDhm?=
 =?iso-2022-jp?B?cXkreDVsMzNQR2NIYWRuK2VjVDVJdGRqRHBqRXl3cEtJMW9YQlhmQUk4?=
 =?iso-2022-jp?B?YnA3ang0enE4WWNZSW44ZFdCV1F3cVNVNUlnOFp0c1h3alFXOXpIQU5m?=
 =?iso-2022-jp?B?MGd6OHpvTlZyUUpIeC9NblE4RUMrY1VodEo5T0M1eGRZSGlXd2pjTExC?=
 =?iso-2022-jp?B?ZmRxZU1aVkp1bTA0WGtaMnlqVzg0KzlLZklPMVpuM2RGdEd3bTJJRjFv?=
 =?iso-2022-jp?B?aklXNGJwek9SQ3diNU1CVDZiYS9EWkE2RWo3dUJVTFlNc0pJMTFUaWNs?=
 =?iso-2022-jp?B?VzF5WEM5UW51Qlh4OU0vbFZRT0lIZzFYTUJwWUJiYml6NUJMRVZvc2kx?=
 =?iso-2022-jp?B?VFA5NGJLRWtiMzgvZWNzdGM4dmJsL0ltNFpqVWhaNXJtdWRocUZqdDdQ?=
 =?iso-2022-jp?B?TmE2ek1Naldtd0VMRzIyVlFoN0FEVTYwRG1LNFhVdjl6WlN1eGhlbDNU?=
 =?iso-2022-jp?B?S3dZajN0eE9tUmFUa0d1YzM2WXZoVEJBSURYc1poT3FQWG8xdUZrRFBT?=
 =?iso-2022-jp?B?WUNxcEdmdnlWazZTMVlsRW1ZOFBadW5lZll6OUh4QUZnUlQrSDgxLzI2?=
 =?iso-2022-jp?B?cWRNU0p4WC9xOWt3RnRjSWsyRjA2Z0NDRmFDYzRPVTdzanFwRndUUGZW?=
 =?iso-2022-jp?B?cTY3U0YxTncvakFSRDMxUVk1dnVqblAzbzN1UndIT0xjUU5NQzRxc3dP?=
 =?iso-2022-jp?B?ZXJIUWFNVHQyV1ljbkZCalFwdFBFeTF2b0FoY29RVHlubWZIaCtwOWY5?=
 =?iso-2022-jp?B?RGNLM1I1UkR1MnEvTUljaWtwY0I0SUtPOTMvUTRaY0M1bC8yNnBnaDNO?=
 =?iso-2022-jp?B?NHczWHhhZ2JsTWhUdDU3SkRULzJnUXJrMENjb2RDeXlEbUZ0Y3JqMEdV?=
 =?iso-2022-jp?B?bFBDQVhIeUZJMTBuSHJFY01BUzZ0YkJleERHaHJFdDNIdTVNYWNVNmdj?=
 =?iso-2022-jp?B?WlVVSTZZL0U5eVp4N1o3bzJXL0hSOGhmV21wUzZoZUk4WFZTdStqeXAv?=
 =?iso-2022-jp?B?eW9QSGtPVGRsOVF2QUkvSythRHNCbDBRY1RqWEE0eUFqOGtxRndVYWxG?=
 =?iso-2022-jp?B?WFJ6S0ZCSTVTQ0F6akVGOGJkN1dCTE9kMk00MjZ2ZEVWOUxjT0htaGNi?=
 =?iso-2022-jp?B?ZUd5UWEzMkJ3Qk1qSUtrYm9KVkI2K2ppS09JL0J4cENKdXcyd3ZlT1lZ?=
 =?iso-2022-jp?B?UjJ6SnJVZDVsTlduelBVYkFxYzhDamtvOU9rTXg3NDQ3ZGVKRXJjZ2w5?=
 =?iso-2022-jp?B?c2ZlZ1ZrY1gzb1Q2cFlkUTREaFRHbGs1REpyTXM2cS93UFdHb01NMWRz?=
 =?iso-2022-jp?B?b2tPQzdCT0VpMUhtTXdZSlNETUZUU1UweDc0Kzdpck50OU5CVHNmK0pn?=
 =?iso-2022-jp?B?OEZrbk1LQ29oeG1UcUlOTUMyMWJiNGgreUVrWUVJZVpzSDF1MmpYYzdv?=
 =?iso-2022-jp?B?eVZEQzg3cGFhM2psV0tEaWNtMVdwZmRGcWxDYnc5R0E2dEQ0Nyt4YVlW?=
 =?iso-2022-jp?B?VmxFbmhXNjFOc0RuRE9IT3ViZXpVRE0yT0hVNHhTa3g5bk1hZ0ZVWHJ2?=
 =?iso-2022-jp?B?dmhnUjMwOEpRMERLaUI5enZPa0c2NVBINkRFRGFsWDFLaGlSSUMyTThi?=
 =?iso-2022-jp?B?dlFYUEE9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6147.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4152873-a6a5-4270-12d1-08db03482c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 05:01:11.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wrds4KXAClte/DKBsA6LOSLXZNeybMrI5WK0Ast7JGzYRsj+SuO78hMcjcgH11qE6XnueytIAYExP2MalNKHcdQIpJaefNzScsNNp6ss93HIHFALneqlAvseVL9f5LDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10133
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 05:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10515

Hi CIP-team,=20

Any comments on this approach ?=20
Let's discuss this topic in the today's CIP core meeting.

Thanks & Regards
Shivanand K=20

-----Original Message-----
From: kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)=20
Sent: 27 January 2023 12:50
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com; 38A5323E673042E40E350B6BD8E7D4A7 <kazuhiro3.hay=
ashi@toshiba.co.jp>; dinesh kumar(TSIP TMIEC ODG Porting) <dinesh.kumar@tos=
hiba-tsip.com>; pyla venkata(TSIP TMIEC ODG Porting) <Venkata.Pyla@toshiba-=
tsip.com>
Subject: SWUpdate with unified-kernel using UUID in the kernel command line

Hi CIP-team,=20

I'm trying to use UUID in the kernel command line for selecting the boot ta=
rget(rootfs) with unified-kernel image. =20
Check the below details on how UUID is used to switch the partitions and le=
t me know what is the advantage of the initramfs script approach over UUID?

* Use filesystem UUID to specify the boot target (rootfs)
* UUID is generated for each filesystem and its value changes every release=
.
* Each unified kernel image is always generated with root=3DUUID=3D(The UUI=
D of corresponding filesystem) in its cmdline and .swu includes the pair of=
 unified kernel and rootfs.
* Install the update image using raw update type (i.e. block level).

Example:

Before update, Active partition: ROOTFS-A(mmcblk1p4):
sudo blkid
/dev/mmcblk1p4: LABEL=3D"ROOTFS1" UUID=3D"U1" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS1" PARTUUID=3D"PARTUUID1"
/dev/mmcblk1p5: LABEL=3D"ROOTFS2" UUID=3D"U0" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS2" PARTUUID=3D"PARTUUID2"

While building .swu
.swu includes...
a partition image (for ROOTFS-X) which UUID is U2 a unified kernel which cm=
dline includes root=3DUUID=3DU2

While installing the .swu for ROOTFS-B:
Unified kernel is installed to BOOT-B(mmcblk1p2) The partition image is ins=
talled to ROOTFS-B(mmcblk1p5)

After update, Active partition: ROOTFS-B(mmcblk1p5):
sudo blkid
/dev/mmcblk1p4: LABEL=3D"ROOTFS1" UUID=3D"U1" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS1" PARTUUID=3D"PARTUUID1"
/dev/mmcblk1p5: LABEL=3D"ROOTFS2" UUID=3D"U2" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS2" PARTUUID=3D"PARTUUID2"

Thanks & Regards
Shivanand K


