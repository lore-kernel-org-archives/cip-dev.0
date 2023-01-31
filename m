Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F170C636D3
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 16:55:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.17572.1675184115135991112
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 08:55:16 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 30VGtBYW029236; Wed, 1 Feb 2023 01:55:12 +0900
X-Iguazu-Qid: 34tMdphy72ybDPwPc8
X-Iguazu-QSIG: v=2; s=0; t=1675184111; q=34tMdphy72ybDPwPc8; m=fSJNLMYUgWVrtYIYmBihWaWBCGdC45tqtgH++XAhXFw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 30VGtAbm007415
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Feb 2023 01:55:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BessFmgWxSzaXN6iTivYULdiceKnInGuYhiHUEm40OHAxa71H+4d9VKG7mu7YX6HhgnJwxFbRqrqp9zNBgl0JeonGZUid5yPYLJlO2FeoUApEFezpRfCU2xa4zxHtXW4OBTuPjO86QQOs+Z9/EBUAiTKWiI3eiiS7FdER5axf/6UzYCEUNhYaTXk/O1tLd4IAFs5wV683qXAe4ZZC+F74+Z+XEtlD/qrMBdYrke25ioF1MiKCOeQ/IdeEabQgiLJxMxm3s9dWFX9xlDQcxUjR1+e/YiY7s8jhMRn3aRZugq3dQ8MWWmW3UA89MmEwrpsvT8mvU6wahB9wmIldH+9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZGTaQiohgSr+4ZYdAkmzme/o4emFQ3S/Jq6DrM69WQ=;
 b=fDuqTrjlFYdFxVhqKIlzEyIBvH5e+4KNqDBOA0A4KvYElN2rYj/rAfDrUo906P1jF32Tzof4XArL3sJqiCsXiiFjVxXXMBfw8tnBdqmZ+/a8E4AmvTLmrM4Y4oiqg+Qe/6LVAOvZs+A3Byv+nN3sVTBWf/mqiYOXef8Ao/Nzx63u7y3eU4ACYYPTFKW/6RP9bWwTPJUjEjg2tGAqB7H2c1P2zUydX76vDGb5YRTUsh1UKY8Tz/5GqapSDs90+qX6n1qL6CZsL1G123ax4Fxvs/js/nNJHL3PzIvSe1DNQ7r5A9m5YaCQRrScyVS2eqegHpviONiU7p60baO3Pe1Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: How to overwrite IMAGE_FSTYPES variable in loacal.conf using
 placement of kas file wic-targz-img.yml
Thread-Topic: How to overwrite IMAGE_FSTYPES variable in loacal.conf using
 placement of kas file wic-targz-img.yml
Thread-Index: Adk1lJkhdAoAy8u6THaeGpMSmHwfvA==
Date: Tue, 31 Jan 2023 16:55:07 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB5542AD9EF2424FAEB3FE588AA4D09@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TY3PR01MB11797:EE_
x-ms-office365-filtering-correlation-id: 472f1a4c-4a4c-4e9d-59ec-08db03abe820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8AaX5/rFz27cgSrR4ErBYPZjPeENjdBDKZpSlWs/8M9KrDJ+biMTStF1Wglg1crwpo0rODTbDoluDRVqNGqOCXSPdRgo1yQeM4b3hxmVd+2IuSyO/hr7BeOZSJ3rsbj0atVPwZQnK+VzHcvApQ7HpMxkb0bjzLexirNYzart2y0vegigGEvN+ePhhQUWidOYax6KarHSVXTFuIMgI68zBzp3CjrZYtpc1vLxj3Bp92d8iv0xvuo7K6jjakMb5F/IajHZtux8CeIhzSPe/AitxVVg0QGAHiXxAvuNh9X91UY4w6Mz0kOa5VFeqOqXunZlP7rh7j+WHEOV1PVpA00eHroPSlJivNmRBw2Iw+YKcYSwsgVWuEWPpijUkUVOXHNJIj7UApNE/D8mG3k/e84zUeOrSD5j2fxiHVBypDzuawhYipXls9P/kj6YDKk2LJMmZcq1O2ISxqECUzv0sVAsL7wB1Byt49DqvBDuTjnYhNZD6HOBv7PwZhXJb3UIAohPXbg1CKcjB4blTq7+/Z8BpKVMAvXnGrcTY4YTxLfo8JqClj9M8DCXr4tBuSG2w1HhUN2hXZ4ACl/q9YklvYKEEnqWnQfPSCKymRf7ODfXl3owynf4PNx6eYnJvPjn1/+eZUINbMrDxFg357pt7xiHnORHANwD+0PktSgbJ4Bsn+nnEoRoyDoyQm8J7QjabCHnIze6BCq63egWKVnt22WOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199018)(5660300002)(8936002)(52536014)(2906002)(6506007)(55016003)(83380400001)(86362001)(41300700001)(9686003)(66556008)(33656002)(76116006)(64756008)(8676002)(110136005)(54906003)(478600001)(66446008)(4326008)(66946007)(66476007)(26005)(186003)(71200400001)(7696005)(38100700002)(38070700005)(316002)(107886003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dmMxY0MrcXB5bzRIMmp3V1VKZ3J4OTFvcTFlQU95cXZxY3pjc0dsU0J6?=
 =?iso-2022-jp?B?OTBtWGdodnh1d0NHYzBMK1VMbHlxRDRQcjJTUThILzB4QWJTNE1YMkNu?=
 =?iso-2022-jp?B?MDFpbnc0V0lpNUhjdk91ZmljWGZ5MWFiRitCaDZxUGRnWFQ2Y2c1a05O?=
 =?iso-2022-jp?B?YnVYNnZ5dGFLaXc5ejFnYmZZRURsRzRFZkJuUkNXUlVCcFZXZWt3WndN?=
 =?iso-2022-jp?B?ZnBPR0QvU3k4NEpaME9vYVpvMk83VGk2U3JKcndlcEV3VzlaOC9xTmM2?=
 =?iso-2022-jp?B?MlZ1TTVmTHNmSkgvTFB5UFZPSXpjNEd1Yk8vRnVyRTdkNkV4cU1zVk95?=
 =?iso-2022-jp?B?cXdCS3RzL2g0ZTd6WWJTdHFrbjdiZDZSc3plaUJnVzRicHVzL3Q2UFZk?=
 =?iso-2022-jp?B?MkdoM1ZvVVV3MnI2Q2p6b05EWG1OTFE1Y1NEVlorQ01aMEczVDJVaEd4?=
 =?iso-2022-jp?B?ZUFOVmkrK0c5T2o3NVFKejRuOFk0cURUNFJ3VkUzMzZUTXRxeGhBVVBn?=
 =?iso-2022-jp?B?NXQyL05iR2x3WjkrUUtROGVGTmxxU01IWW1LMi9zYzlIRGVUM1pGREp6?=
 =?iso-2022-jp?B?eFVXdkhVaXNYZVBJOUN5SzNLVnJYS0pBZ2trZ2hSSkF3NFdMVHpHbnor?=
 =?iso-2022-jp?B?bnNXeWFxUmFBSXdESHh4TlBnZGczUy91clJHREFzc3ZqRjc5UG9VL2Jv?=
 =?iso-2022-jp?B?eWZMemdWQUs0MXA2blBwemNvaDhyNHJ4V0ZEWWovd0h5VlI0MkllTjRq?=
 =?iso-2022-jp?B?aVFjYm1aM3A1VnZYWmRmWGpBOEJ3d0hhMmUwUkxQNGRFSWZPS28xY2dU?=
 =?iso-2022-jp?B?TmJMZDNzUXVTOFMySDhyTFNOOEdpWTJOOHJRRTVYTzFUOHdRbDdmMllS?=
 =?iso-2022-jp?B?WEdCRWhLaVZaeGx3NnZWVmNJak1leGtYOHY4Y1I1dnB4aUNodjEyWGJI?=
 =?iso-2022-jp?B?aDZjSk1JemkxTTFhcm9iazRlMXoyN1R3Zkk1d05FYTZYZENOdlpQU0tz?=
 =?iso-2022-jp?B?YWtXZm5KeUVHVlhQU244WmN3cHdRT3lLQ01KdFgwRTg2cEl0bEEvWmFa?=
 =?iso-2022-jp?B?UUNtS1hGcG1CYjVGdytuamZtclJiYlJ0VDdZYTE0bG1YemsySlRwczlu?=
 =?iso-2022-jp?B?VUYwU1QzM1VjUXg3TG94b0dLbk5MazRXYnl3Q1UzcTAzUld5YW92cGU5?=
 =?iso-2022-jp?B?cW1mSzlRZUxXdzBrOFhnQkxQdUxQVzNBRUVZamJLd0hKYnZlM0RncFhI?=
 =?iso-2022-jp?B?dkw0dkRPNVA2TnluWmQ4dGpuYzhWSWhRb2E5NWRDZjdZVTNZcnUyR1p3?=
 =?iso-2022-jp?B?M1FkN21kU1hmVlIxazdDYnNqaS9tTjkzVVdZQloyZjBDSjFxaVlVcVFR?=
 =?iso-2022-jp?B?UU9mRFloWHMwdXJNOU5leEtKVWZ6UWNJczhNOC9LdU0zT2dhaVUrSlpD?=
 =?iso-2022-jp?B?UzN1T1l6OFFVU2h6M2ZScUhycEF3c1Nlc0xoZHhBYk1KVVE4bmtiV2dZ?=
 =?iso-2022-jp?B?QXpLOVJ1bHVBUHVrY25sL0dJMjlSdnRacnB1bVJKNFgveDNvMVN4aHA1?=
 =?iso-2022-jp?B?QmZhN0JoWGJzbG8weGpRSm5BSmlhaGZ6N1pHa2RqYTBzODdybWNCSE1O?=
 =?iso-2022-jp?B?NVRMb3hrZHFLZnpjNUlHbTdwUXhaUFpIWlkyaFZtNU04V0NZUnZhSmtq?=
 =?iso-2022-jp?B?dGFnRFExcXN3SEhxcDJraWN0T1FnaXNlWUwxR05IOEgwMkpiSkdwMXI1?=
 =?iso-2022-jp?B?bDNwMUk3S1JGV1JJbWdGRUppWU8reTdTK012a2tzYm9QREF6NlFLT1VL?=
 =?iso-2022-jp?B?TGE4SFNGNUsrd0o4WGZlTEFaaEdFSFdGQVdxWGw1MDN0M0I0eXVLZmwx?=
 =?iso-2022-jp?B?Sk5FMDdvUGhPNGo2SU53dEZUM28xUUFLdmpkQXBwOGRQYWpHZW9UZ1Br?=
 =?iso-2022-jp?B?MUZXSzg2MG16cFoyeEtjdzRHbGR2TllKaE1wcE1hYllxVjJkSnNQTGJz?=
 =?iso-2022-jp?B?L2Rtb0ZKcVE2OW1aRkRVRXc0RVVCK3JWWVgybjFzY296bmVEQURUcjNt?=
 =?iso-2022-jp?B?YkFSZVpobm9JRnd4QU9RZGVneGlFWm1vdHVaYStMdVAwUWpMVktlUlpE?=
 =?iso-2022-jp?B?WnZ5cEJObHllS0pXR1lJOGpkYk9yUTBOakR4UHorejdoL1dDMFdkWGhL?=
 =?iso-2022-jp?B?T1lzY2p1ditRQWgzbmFQY202bitmWnFGZXVyNFk4aHJsdWlFVHV1Q1Q5?=
 =?iso-2022-jp?B?bkxjUXBJT3oycGNqU3hUdWlHYXRoSVlFVmVNbkQ3R3NqbDFmaXJneUxq?=
 =?iso-2022-jp?B?NmRHZytlQVQyVjRGVGxzRTlZY2tGTmZZNkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472f1a4c-4a4c-4e9d-59ec-08db03abe820
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 16:55:07.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n01AfEg57hvMMQjMSrleXGumdYnQpnoLKt1wJ7PnR6265CFBP9cypAnuUS1YTl2WrXrZL4mW3QGe+xhirZFubCNT9ACjhP+wS/BDX693RLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11797
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 16:55:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10545

Hi,

I am trying to overwrite the IMAGE_FSTYPES variable with the values in wic-=
targz-img.yml by keeping at the end in kas file definition as shown in belo=
w command, but it is not overwriting.

$ kas-container build kas-cip.yml:kas/opt/ebg-swu.yml:kas/opt/wic-targz-img=
.yml

kas/opt/ebg-swu.yml include local_conf_header as below
-----------------------------------------
local_conf_header:
   ...
    wic-swu: |
         ...
          IMAGE_FSTYPES =3D "wic"
         ...
-----------------------------------------


kas/opt/wic-targz-img.yml include local_conf_header as below
-----------------------------------------
local_conf_header:
   ...
    image-type: |
         ...
          IMAGE_FSTYPES =3D "wic tar.gz"
         ...
-----------------------------------------

Final conf/local.conf generate as below
-----------------------------------------
# image-type
IMAGE_FSTYPES =3D "wic tar.gz"

...

# wic-swu
IMAGE_FSTYPES =3D "wic"
-----------------------------------------


Expecting conf/local.conf
-----------------------------------------
# wic-swu
IMAGE_FSTYPES =3D "wic"

...

# image-type
IMAGE_FSTYPES =3D "wic tar.gz"
-----------------------------------------

The above is possible when I use name with higher in alphabetical order lik=
e 'zimage-type:' in the wic-targz-img.yml
kas/opt/wic-targz-img.yml with=20
-----------------------------------------
local_conf_header:
   ...
    zimage-type: |
         ...
          IMAGE_FSTYPES =3D "wic tar.gz"
         ...
-----------------------------------------

Is this the only solution to set the order of the variable assignment in lo=
cal_conf_header?


Thanks,
Venkata.




