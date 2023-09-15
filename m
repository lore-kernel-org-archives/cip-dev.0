Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275AEE021A
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 03:33:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.13436.1694748820271937426
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Sep 2023 20:33:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38F3XcF74020953; Fri, 15 Sep 2023 12:33:38 +0900
X-Iguazu-Qid: 2yAaUxDRJAl5bLH5XA
X-Iguazu-QSIG: v=2; s=0; t=1694748817; q=2yAaUxDRJAl5bLH5XA; m=pkeG5uw68EbWalS/5TpGqo9TdltkY37iTUwSjVrp8ME=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 38F3XaS41264311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 15 Sep 2023 12:33:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCzATVoRmK0P278OZmzZ/ukgKpN3MyHoJfywyMGmXMM0nI3rtEOm4Q4ehEX6NzdxzTzD8SGpCroxAau9Nq9HOeyWbvsKV9zdY7fEwQXhZqtXZbCgxQpNGRoz8sBhSmCgpROU3aT3fwZ8O1xFd7SC3Co3I7SjoTrZZqHtyHe8eoCaY/UnKAjB6ZELYeM/kIJ/X/RizeMcnClErHfYFq/Eh5SLq7q+47FTeCbjP2j4rivZ6mtDKn0MTL50t/QQPKBTH1dAv1YGt8Z2OFH88b9mDwaHdOvCOpyxeVDJ5i8Vwv9UwjeSQ/QTkLRl3KKxcDHLupI3y7HOaxl4QhiyUsUQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag+8Bz4vBQ7nAJ1/U7mIGhiKA59XZcsZ32sBPIPVlPE=;
 b=ikRX+QHEXJxgQEEu132VoKr4gTKqDZWmnhMMcIcElvBcL1w+Cwyd1QqPVeCRCC44OtkZsoIZffcFGGopVddbdPRIs9G3QcOIYmLVsXTlIivjVynTUvUnGpDytz0BjNBTH5IYq3FI5NCm8NrLMXOE6yJlwMwm1c5ntEZtHRfrx6DVdz6A0CcurXV7NtB9aCvAW9aGA+lHM2k5e7MiGCxpMZ62tw+rlVJftumXOzGSTrhbKs9DlYwEmkse6cc+d8W2co23+PDWsnf1W6Dy9/gS7n7YK7VtpPyj1qMnrKjyVHH9UhFaupt+guuCUdxXsSON9kieXCe3W93hetXwNmehYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <felix.moessbauer@siemens.com>,
        <jan.kiszka@siemens.com>, <adriaan.schmidt@siemens.com>
Subject: RE: [cip-dev][isar-cip-core][RFC 1/1] classes/verity: Set salt and
 uuid for reproducible builds
Thread-Topic: [cip-dev][isar-cip-core][RFC 1/1] classes/verity: Set salt and
 uuid for reproducible builds
Thread-Index: AQHZ5zx1vJs/DyuLeEamsRsQmkdFy7AbOq/Q
Date: Fri, 15 Sep 2023 03:33:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55428291C0BEEF014A75CAB5A4F6A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230914185102.1451907-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230914185102.1451907-1-Quirin.Gylstorff@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TY3PR01MB9680:EE_
x-ms-office365-filtering-correlation-id: b0bd1efe-ad0d-4342-59c6-08dbb59c8a8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rG8kGjCaMIq4BqIYG/3ILXkQJ8bsGRwtmwuJkBLMeEmuSZQFzKcOV7+E+SY9697pijH5btBupubfd/dYbdsnAmKRYZPlK3d4A+TQj3OqO/nAdT6ioid3d/kn05yTMfmFO8C/2yKkgy21/lFOxQer9OJntizpEgMK9qToKOsBVLhawEOxxVnz2eXPyle74BG2WdoL3dPkKpb+5mdRO3EpMzPy5nwrdiHX3fktPay1XbORWqmETZbBceUTTJvFk2Vhncojx/eCtHLjWYHw2fnUqbLmu0LqDGldg9rRen8pt+LllAFrQ8JNbX1GPk+mEdNJJI+i/NxxIIadK1so29meov6sjC0Ny+Oj89PcI/1chcRV58fCbsayJsW0KhHUkmUFt6Hj8LQ6gae9hiPV4MIfoJR1EWiBW/sbAJ111ZYnN7HQga3NIA4FK9gYyh8KrySo0wWVYn4mndHrlEs5Tyb6XItBWd8KfZg4D5oChWlopaVpG8dkg/grAROqtkA9ylxTTVdfbelo4QYJwRnmrgsaYxJ+hD2FyAIB1FLF27gh5nGy3NxA5Y+By95paxuIbMMTC3PMRfnTOb7qFIlWrrouC5EpgxBXv0jrhcwvKDmpvfRVZyPvnzMZrA4dqvznYP3O
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(9686003)(55016003)(71200400001)(7696005)(6506007)(26005)(66946007)(33656002)(8676002)(5660300002)(8936002)(86362001)(2906002)(52536014)(41300700001)(110136005)(316002)(76116006)(64756008)(66446008)(66476007)(66556008)(122000001)(38100700002)(38070700005)(966005)(478600001)(83380400001)(403724002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eGhWMWdMUGZHREZBNTBhbFhGL2IyY3NEV2RBLzlzS1hsNmEzejRoU05l?=
 =?iso-2022-jp?B?clBFdjdIQzNXM0FWRzdtdEY1UDJObjZjZFFBVmFsZEg4akRDRHJ5ODFz?=
 =?iso-2022-jp?B?WkRNcUMxRHpGdkRSM3VjUnQxV3ZVM0lWaXN3U3dvc0lxYzNuZkNrSVc0?=
 =?iso-2022-jp?B?a056R1RJUmw0eWhwN2FjYld5TjVKWWd5am15bURGSnFIVmZIbStEL2Z3?=
 =?iso-2022-jp?B?NVNiUENqNkU1cFpneGNnWGE0dDRnYm8xUnRMVENZV09DSjZKUlZQeDJX?=
 =?iso-2022-jp?B?Mzk4YXJ2K2NJaEFDS0Q5U3AvWk94OXlzYk9xV1ZpVDU3cHNmUDI4QTVH?=
 =?iso-2022-jp?B?Qk9ndUNGdzd3WVdQdE04VTZzZEtMSHAzL2V4MXpUMUs0T0VNZGsrRGds?=
 =?iso-2022-jp?B?OEdVSUZBM2ljVm1icVJ1RTBVOStlZTVtQ2Zqa3ZhVlQ5Qm8vZ01MZERC?=
 =?iso-2022-jp?B?VjBCaHY1SitWUzVyRE1sdTNua1B0NzVtaHlHMGR4dmxjVkVqaXdDMmRG?=
 =?iso-2022-jp?B?aWlkODdqQ1Q1ajZ2enBuQ3pxTXFBbTJlcm5ic0paYkJqVDh6UXA1NWlq?=
 =?iso-2022-jp?B?M1dXK3VoMUU5QUdMRFloZ05DZUhsYzVtOHhzMXI1S3hxK0dSemt1ckRv?=
 =?iso-2022-jp?B?M2ltK1FjOXY1ZnNWWU1CS0xBSWpzb0ZtalFRdnZzYXZFV2lLeTZOUFRF?=
 =?iso-2022-jp?B?YzdHaFlFRkJRQVhiWWNWcE5iYnZvck83MDlLOWlRb2dLeTlmb2psL0o0?=
 =?iso-2022-jp?B?by85aVVnYlk2WVlQOEcyV09UYXdJcEd3OWQvVVZtWHJYRWU3VEsxV1hS?=
 =?iso-2022-jp?B?TmRqRzFKK0VwK2JBeTIvenF3VHIvMUxFMWx5aGs2ekhDbTZGWk1QYmFD?=
 =?iso-2022-jp?B?Tkd3U1B1Nkp3RGNPL0V2YmE5SmRoaFZkYzNBdkFXWnlwMVJ4T21BMTZx?=
 =?iso-2022-jp?B?aFZnWW9uTDVXQ3FYdEdleFppdkZQK2YyeHRXc3VQSnhPcndFL25KVEMx?=
 =?iso-2022-jp?B?dWVPaFZJaGUxRmh5VHdUalRDemg0c0VzbzhsMitUWEJsK2hBTVRlUGVY?=
 =?iso-2022-jp?B?WDhtZXVNa1MzS25sMitiWkJVUk1LVVc2TUtBV2V2dGx3UWwyRHlFWVE0?=
 =?iso-2022-jp?B?bzBZVjV6SFBXZ09nTnhjbEc2K0JidU0ra0RCQ2pmcUNCWEtEbUU2aWwv?=
 =?iso-2022-jp?B?M3ZEbFBaVmdNQ244QzhXZW96QnNRRmZpTGVGSmZOMEx3VTl4R3JvdVBl?=
 =?iso-2022-jp?B?cDB1WkF0b01YNFR3clI2ZlgxMWpUZUJRU1VlS2xXanlzcjMrbHlNZXhj?=
 =?iso-2022-jp?B?NkJ4bzU2RE55TGQ4WEkvLzhPK2lybXlNR1VmQ3hrWkQyV1BoNEs3SXpJ?=
 =?iso-2022-jp?B?T1luM1VsaW9kMjRKOXU1b3l6d2R4b2laVVVlamlvd2c2eTI1S3FQUlN0?=
 =?iso-2022-jp?B?c1NxRjNQczZwTmFhd0pkVVllUlhaMG5pZHRxR3lnZkY2dDZZTWE2SEcw?=
 =?iso-2022-jp?B?cGpQZTBtZEpFNTNDYUtQYnNWcGFsYUJMNU01T2ZQeXhLaVpHOHNGOUpq?=
 =?iso-2022-jp?B?Qmttd2NZVEJmR2xTNjhQY0JuSFpmR2FTaVBLZDBpNTUvbHZaUSt5OEo4?=
 =?iso-2022-jp?B?SWlFNkdFTnUxTjZidHVXRWZRaHRwZzNTT1pyQURXbjlUeThJQ0xFc2ZT?=
 =?iso-2022-jp?B?c05FWkxJNEJsUzdvMXJlTHJaakdIZWVEeXJwUXAxYWRSeFMvaHBNVXNH?=
 =?iso-2022-jp?B?WU50TWdIRjdJNXkrMlVqSlY5b3NWVUtQZmt1ci96cUdsamk0YmFuUFBV?=
 =?iso-2022-jp?B?dm9mN0N4TSt6MUp1bEt4TDRId21Fd0xhOXJ0VHlhSDdWT0h4Q2ROUnpv?=
 =?iso-2022-jp?B?YWxGZEh5dkxXNWRqajJiWmxqa0pqU0FmdEVNT3FpZ1BRcWZzcHF3b093?=
 =?iso-2022-jp?B?MFNGaWQzSHVhZWV0NWVQdldhWG1KRCtFclVFckxWaDFLMzl1VG5rS2Fa?=
 =?iso-2022-jp?B?Z2kxak5jbyttdFZFdEx3bU5iNDlYZFRrUDgwdEZJcnppOE53bFZaTXhs?=
 =?iso-2022-jp?B?bURhSkRNbVNkUWptSDA1MVZ4Y1d0QkIwWWduQ0NQdis3WUNRbEJiY0kx?=
 =?iso-2022-jp?B?eHU3YTd0V3ZqL3ppZjZNMzgzVjNFRnJSZUlnR3hmc3Excnl5bk1PbUQv?=
 =?iso-2022-jp?B?UWFGQ2xJWVJjd1RtWTB2WlYyT05zRjBMbXBCNWNQZXNEL0pEbTRYN1h5?=
 =?iso-2022-jp?B?dm1aMlEvTFR0N3kzNVNwdkV5WEpDQk9JMWZSSmdrVFJId3BLU2ZjdG1a?=
 =?iso-2022-jp?B?cmtiNkxOYmtXWVUxUkUwamMwaXBpU3JqSGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bd1efe-ad0d-4342-59c6-08dbb59c8a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 03:33:34.6552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axzSs76v1NjJtGcSLteOu86nlHljtkI77v+qzmgSBFJiJPDynCKLUK+npF+/LTYZF64LEFiz2xcgGMG7PS0DDtVYv2x+/EQEs9fkDi6QB1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Sep 2023 03:33:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13134



>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>Quirin Gylstorff via lists.cip-project.org
>Sent: Friday, September 15, 2023 12:21 AM
>To: cip-dev@lists.cip-project.org; felix.moessbauer@siemens.com;
>jan.kiszka@siemens.com; adriaan.schmidt@siemens.com
>Subject: [cip-dev][isar-cip-core][RFC 1/1] classes/verity: Set salt and uu=
id for
>reproducible builds
>
>From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>
>Currently veritysetup generates a random salt and uuid for the verity file=
 system.
>This leads to a changed root hash which makes the verity image no longer
>reproducible and bootable.
>
>This also fixes together with the option `kas/opt/reproducible.yml` the is=
sue that
>after a sstate build the image can no longer be booted.
>
>Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>---
>Can we set the option in `kas/opt/reproducible.yml` as default or are ther=
e still
>issues open?

Yes, there are still open issues in reproducible builds, please check them =
in below link.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/?label_name%=
5B%5D=3DReproducible-Builds

>
>This patch superseeds `[cip-dev][isar-cip-core][PATCH] initramfs-verity-ho=
ok:
>Ensure sync on rebuild`[1].
>
>[1]: https://lore.kernel.org/all/595d5791-a08d-f08f-5dee-
>6f9ed5d472e0@siemens.com/T/
>
>
>
> classes/verity.bbclass | 34 +++++++++++++++++++++++++++++++++-
> 1 file changed, 33 insertions(+), 1 deletion(-)
>
>diff --git a/classes/verity.bbclass b/classes/verity.bbclass index 747a7ae=
..2cfeb28
>100644
>--- a/classes/verity.bbclass
>+++ b/classes/verity.bbclass
>@@ -18,6 +18,34 @@ VERITY_OUTPUT_IMAGE ?=3D "${IMAGE_FULLNAME}.verity"
> VERITY_IMAGE_METADATA =3D "${VERITY_OUTPUT_IMAGE}.metadata"
> VERITY_HASH_BLOCK_SIZE ?=3D "1024"
> VERITY_DATA_BLOCK_SIZE ?=3D "1024"
>+VERITY_IMAGE_SALT ?=3D ""
>+VERITY_IMAGE_UUID ?=3D ""
>+VERITY_IMAGE_SEED ?=3D ""
>+# TODO split if working
>+python derive_verity_salt_and_uuid() {
>+    import hashlib
>+    seed =3D d.getVar("VERITY_IMAGE_SEED")
>+    verity_salt =3D d.getVar("VERITY_IMAGE_SALT")
>+    verity_uuid =3D d.getVar("VERITY_IMAGE_UUID")
>+    target_uuid =3D d.getVar("TARGET_IMAGE_UUID")
>+
>+    if not verity_salt:
>+        if seed:
>+            verity_salt =3D hashlib.sha256(seed.encode()).hexdigest()
>+        elif target_uuid:
>+            verity_salt =3D hashlib.sha256(target_uuid.encode()).hexdiges=
t()
>+        else:
>+            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_SEED are
>+ empty. Could not derive verity_salt.")
>+
>+    if not verity_uuid:
>+        if target_uuid:
>+            verity_uuid =3D target_uuid
>+        else:
>+            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_UUID are
>+ empty. Could not set VERITY_UUID.")
>+
>+    d.setVar("VERITY_IMAGE_SALT_OPTION", "--salt=3D" + str(verity_salt))
>+    d.setVar("VERITY_IMAGE_UUID_OPTION", "--uuid=3D" + str(verity_uuid))
>+}
>
> create_verity_env_file() {
>
>@@ -49,8 +77,9 @@ python calculate_verity_data_blocks() {
>     d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))  }
>
>+do_image_verity[vardeps] +=3D "VERITY_IMAGE_UUID VERITY_IMAGE_SALT"
> do_image_verity[cleandirs] =3D "${WORKDIR}/verity"
>-do_image_verity[prefuncs] =3D "calculate_verity_data_blocks"
>+do_image_verity[prefuncs] =3D "calculate_verity_data_blocks
>derive_verity_salt_and_uuid"
> IMAGE_CMD:verity() {
>     rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>     rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
>@@ -62,6 +91,8 @@ IMAGE_CMD:verity() {
>         --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
>         --data-blocks "${VERITY_DATA_BLOCKS}" \
>         --hash-offset "${VERITY_INPUT_IMAGE_SIZE}" \
>+        "${VERITY_IMAGE_SALT_OPTION}" \
>+        "${VERITY_IMAGE_UUID_OPTION}" \
>         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
>         >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>@@ -70,3 +101,4 @@ IMAGE_CMD:verity() {
>         >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>     create_verity_env_file
> }
>+addtask do_image_verity after do_generate_image_uuid
>--
>2.40.1



