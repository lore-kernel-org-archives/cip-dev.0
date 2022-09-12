Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF797C6FA8B
	for <webhook@archiver.kernel.org>; Mon, 12 Sep 2022 13:16:59 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [104.47.23.107])
 by mx.groups.io with SMTP id smtpd.web08.7316.1662988608973983504
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Sep 2022 06:16:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=CPbcSi5d;
 spf=pass (domain: renesas.com, ip: 104.47.23.107,
 mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0DE07UCVgX5ukEq/8UovxzoqeLoJgA0P9WvXlUjwiWUW/4TN5ILJLee0e5MKx0A4cJifEoPAJY9a8Dvv3GcoJno85B+AIfsBEoqeG0xxEHUvQE6CCxnf6QIbnwGdVWiRZHr11p2I2+z+Uh4t2+hs2A49ivXiZK4AMwmmG4AK+mI6KR21tEiKaQf4z+0Nok2pBXKzD0+UoIa8dgHbGpOrPGk7jre6KXavEAaP1CFgl36MoJG7kgaERn4SLby+lzaGcLeIU9THooarmR8KAOsPvoRQcgXfeBoBRuNt+wETmCqJuOo14RF0cvNdSsgwLTyogYdZW8aYrw8ETEoqBXUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZZca8OeX9N/Rjc6BdCpLodklxwR1n37dg3ULWvN1zY=;
 b=cQeRwcYiiAAiU4IwCfI/eLaw3rLS/mnJxRiz4O7DLmXE3OAj+YWqfNey35aTwPdCzC+KTpMKtjjaE5t/kKVIw/TJDfGqibWzLI0n1LL0I+Ic8x9p6Szxcf6pVsc3QX3nsuAgxxbePqJZEQ/gUqAKDhwBeGWi8jq+mX4t5n8/lsGQLd/3436sfE7gTq/3EBbwLkgoyunqw1fPLHD7gZHa0gU6oeBDNE6SfUMuXA/NEvHU5AdmU3xvoDJN2AB6jHk9TwJOa5Wwf5IrCoGRROxAQwKXqwfRZEkBEuPYtNPw7NEJIFIBNIkYteZTCbPyaZYPabrbu7kOh/pmgClpx6dLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZZca8OeX9N/Rjc6BdCpLodklxwR1n37dg3ULWvN1zY=;
 b=CPbcSi5d9eiJ+OBkq1BaFRKEftGcyUKWZmoTKfP3S1kOKdOzV2fS7ThU1aKEb25Q3AGBRBie6WRf13Eom/v+UoECiElw/LC7mQTftUYf9UahxhleIqM9iFUE2bPvcSll7DrgrxaSuC2i6wCMMhCSktHwOMM53vcJ07zvovLGu7g=
Received: from OS3PR01MB5976.jpnprd01.prod.outlook.com (2603:1096:604:d8::13)
 by TYWPR01MB9439.jpnprd01.prod.outlook.com (2603:1096:400:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 13:16:45 +0000
Received: from OS3PR01MB5976.jpnprd01.prod.outlook.com
 ([fe80::520:15b9:595a:9ef5]) by OS3PR01MB5976.jpnprd01.prod.outlook.com
 ([fe80::520:15b9:595a:9ef5%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:16:44 +0000
From: Hung Tran <hung.tran.jy@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core] iwg20m: remove fixed PREFERRED_VERSION for linux_cip
Thread-Topic: [isar-cip-core] iwg20m: remove fixed PREFERRED_VERSION for
 linux_cip
Thread-Index: AdjGqcFv6qAokmlVRYee3B1XMdH8Vw==
Date: Mon, 12 Sep 2022 13:16:44 +0000
Message-ID: 
 <OS3PR01MB59767EDA1F2EA8ADD1569ED8C6449@OS3PR01MB5976.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5976:EE_|TYWPR01MB9439:EE_
x-ms-office365-filtering-correlation-id: 08fc6997-54f5-46ca-264b-08da94c10a18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nYem3GIWWCBD96afqgGUaohUeHsok3lbzixG6vt+jzUv7bnllaEgpRFweG8K+hrUGlhYLRiIHUc+gDGIt3Lw58dLPBJuJ40bwlN/+uVLtWoLQ2ffN6Bh6NfKtJeqjIhhXtefgeEV+OeHatojq8jvwhdioNFiENV2W1UllilQP1HUzIBpJLjXChz8fcPK5ieoOdSfe7cYFoYakMU2ytkOQUFrvoNOjitRjDYBHFbDuvXpIdqTceqhOoW7Z1ge/NzdvAorKh9E/5a8htQO6WfvvizQwhaD0X0poAvG2xp1YKCVWGe802nmA1PSaImT10TWRg2pez/LTFA4fkXL8+1g1rLR96rW19ilJ2hGyBZB/rrYm86Dt0Y7/aMqBAbsiWVGmVqdDatKBwV1bQ9NQKpolZxqKeB2TupJp3QI0Ypp61DvDs+jGtBirueIEfHfByqlbzLpGejt8XLPI6MPuvALvoS9I+U3ofkTFbYCiySW7l1aTiisoUjCVlf73CVaRTvtks4xzhGT9r7SYvkt46Q6yqZd49ir6BHRmX3pitkbmgBdwNjp4C7+bvH0JXGV0io74QbaBYoOmEZDSwXRkhCCoGuzCSX3JG+zK8q5bJKGwn9A1k8OwSQUTUmrXfw0Am0XY1KWLNk78mHd3qCeFv/wFCERiqw2dN5NEf97UlXCrOTzyRoRdt+NETCqiMChGw/So4mn1I6V0P+o4tCwE8RvNUFFlIdqdJoXGu5lp4Xz35U6SM7fi61KrcJjCpM0ZsUlG6EWZOfXshNspTd+oK121Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5976.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(83380400001)(38070700005)(2906002)(8936002)(33656002)(186003)(71200400001)(52536014)(478600001)(5660300002)(122000001)(4326008)(26005)(8676002)(9686003)(66446008)(66476007)(66946007)(66556008)(64756008)(76116006)(316002)(6916009)(7696005)(38100700002)(86362001)(6506007)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7iiFK1pQkXjvbGLTRiMSA64p7edT1GDGwTApKx65itcgJTPqqzuwtFN6T9sa?=
 =?us-ascii?Q?TDYfBi/qQ9cQYa+euMGAvzHhyz3s4RcSQR/wEFpda3zVgH7bVeQws9RFxm2r?=
 =?us-ascii?Q?g0E2S/1wM56/YN0WR9LOAaMDKDdPboc3XrdTp6z6+IdhXSDQreWpHKWHa8Bc?=
 =?us-ascii?Q?T+gfRoqPk0IDZMJ1HixJfuvaX7kXafi4r66FmToHfywIoT2FiMTNNuF8gKuz?=
 =?us-ascii?Q?CGrIbDZ4zuQXy/TBYvxZF++1RkvDA7TW8OMcJmehWzR5AjH+ZlGfnQql/Fqd?=
 =?us-ascii?Q?//2ox4Yb/MOMzen6jfbVsPZHMAZ+1oGUyGFmNdoVX9PLO0TNkjeZ/D5owYgn?=
 =?us-ascii?Q?1J25xwL62HKSqB3FhxBlelbrpaa7phvZ/SkHJSyxX8h9g+b+JxyYKKFL3bDe?=
 =?us-ascii?Q?SMEvoUoywmVV5KrgXKVqJvVRIfRKKfcTHbatex0ev+nfpKbKQeDH6JEaPDGW?=
 =?us-ascii?Q?nQ49FhKhjjOcLz564B3/0ySAOrID6oYtGXFVCnIEoJT8eF9CY0RlVDnoZI1b?=
 =?us-ascii?Q?qMrQq0s10DTJLKmUSMDHni6wBn7Ct+QhYouqVxolOXhMdXN3cJtDFCFOAn36?=
 =?us-ascii?Q?STI9AulA5r4LoYI9S6NRdF51oF9bgktgB8812XNLfNZIEKN+zopp2Jxj1EIb?=
 =?us-ascii?Q?0/gijX9MP1FtUpXsZUbZdfssElvVuNQQX1DKnYnU0szXDoydSsNojw12tTIL?=
 =?us-ascii?Q?YONOIPf2knb0L2UorvQ/wlpdazujCAbN8105QbmzjMxQjOjOiCq3V+1sv7T+?=
 =?us-ascii?Q?vSEyas2PSWoH2dqdrSEi+eFokdu1+SL1IEDtwl5sj31QJmuYI3U7s/dV7z9R?=
 =?us-ascii?Q?0cASREiWXgWJTm/WT4U4Kmu98koAiv5mn9h/v+dBBQ3WYTXOE96zWSkYoG4e?=
 =?us-ascii?Q?cPUsPDgbPCMYYYJKaxwNTJ6EaySrS1MTURiOAXff767YbYrcpaHPOmwiuNNK?=
 =?us-ascii?Q?dVrryRX9CJ937G2aBO3GDRUp3hd+/yUIGRms0+PxxUHkCfbnvZLprjMsVRHx?=
 =?us-ascii?Q?B2wonE0rwtEZwY7ranZtt66OKRh3Po/bsuyXplSLd5SymgD6npZ6V2xdPYf3?=
 =?us-ascii?Q?BJHeZm0PHgo1QqXxgHhzIzNUdKVW/j+zLNh8EZJsFmsFqxOlRNKyW94aiVz8?=
 =?us-ascii?Q?iuNBZdFWAN6iwe5fKkDcx7UApl2Ek8BE+m/R/+2hQYq5t1nHmn7Rq+ZbD8lC?=
 =?us-ascii?Q?yaqkE75R9C4UbTd4Wo5d8FsQH7eGeMFlbPR1cxTeHsD06KemypHZOgir0bKC?=
 =?us-ascii?Q?GdnhcaNzSp0l+xxgZIyULcMJ203G0SDmdeii9wdLwAj8Wf0EeGIJ3ecWBOzV?=
 =?us-ascii?Q?orMgS3BjRB+E2gUcLvbysq3hzbRZfWbWzmRwIBKSPI59gcS3GEWAn9LtpTAm?=
 =?us-ascii?Q?JbhdPrTA+9GahmVIW5Nb44jtyjM8DzhxRZ8MMKqEaSwTMvkq2uKSqRm+h6j8?=
 =?us-ascii?Q?Csi0jKT0bQesSe1V0EQ2rh64Gjbmz7dgNcVUe6Ziwz54dpt9dcVKuMCDMfZM?=
 =?us-ascii?Q?eU+00JioMQ/YUBC3LfG/z8VPqgwlHZzDd+icffAjiE2sI45tm/KRWPNzMq4m?=
 =?us-ascii?Q?e/8NgruBR8NrpQm/0FwSUifB/kEa7ozXlw4u4bMQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5976.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 08fc6997-54f5-46ca-264b-08da94c10a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 13:16:44.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 OWipaKnR6JxC7JJJDbqOSV0bpwZIrpGhXkLBWsWAsyJmP8XpT9AnT02CnEYEe0GTfk/AwWVYGh7aZnSb9YJzzDVTR6pYCkSuTHLpTNBMyns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9439
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Sep 2022 13:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9489

From: Hung Tran <hung.tran.jy@renesas.com>

iwg20m had PREFERRED_VERSION for linux_cip as 4.4.%
Due to this setting, Gitlab CI always build linux_cip
version 4.4 for any iwg20m build targets.

This setting is old, and not necessary anymore.
Remove it to allow building suitable linux_cip versions for
each build target (4.19 for buster and 5.10 for bullseye)

Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
---
 conf/machine/iwg20m.conf | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index d997a02..f5d5dda 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -14,13 +14,9 @@ IMAGE_FSTYPES ?=3D "wic"
 MACHINE_SERIAL =3D "ttySC0"
 BAUDRATE_TTY =3D "115200"
=20
-# kernel version
-PREFERRED_VERSION_linux-cip ?=3D "4.4.%"
-PREFERRED_VERSION_linux-cip-rt ?=3D "4.4.%"
+# Setting for kernel and boot
 USE_CIP_KERNEL_CONFIG =3D "1"
-KERNEL_DEFCONFIG =3D "cip-kernel-config/4.4.y-cip/arm/renesas_shmobile_def=
config"
-
-# Boot partition files
+KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/re=
nesas_shmobile_defconfig"
 DTB_FILES =3D "r8a7743-iwg20d-q7-dbcm-ca.dtb"
 KERNEL_IMAGE=3D"zImage"
 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
--=20
2.25.1


