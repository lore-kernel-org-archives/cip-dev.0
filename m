Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C53C4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 13:15:03 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.48])
 by mx.groups.io with SMTP id smtpd.web11.7572.1666185301773769824
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 06:15:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kBKfhRKA;
 spf=pass (domain: siemens.com, ip: 40.107.14.48, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT40X+V60m3D8+XOUw7JR/tW65oU6KPK0ROH0xvOqYC1kRCiKBlk08OPhojeZKyNzACzY/+IMHP7Kw1w6LXtHxqCrEOekWxZZmFUU5C2gF4tMF9kwZEbCwkoW73dNmgKUJCy3RUTqkKnEE/oLwIuaa5dx9MVzpEJjhGJTkpwMvnR+rBpoJD5F+oK2h28zb+xLxIiUwbaMbNAF0EtuS9SJDwmQV+pIPIBqW/f3opineNl4ug+FKBywyVibP4ssDYKHm7x6vjHwbP5kzPDmSC1NZ3VIoCdoq0Im0nMBdxvYrTPy+GgUqUv+bkyULGBJKE5x39C+tJ7a5dRy4+aud5gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfBGVdFSiRsESvqLSvNc4ESjtrWNOebaeM81LV42YIY=;
 b=B5pmm6OwwYwkox6Fr/maIVWAyCjdAfDWIzZiM+lLESgZupIQTe9ql2NJUu5Y1WzasmJ6DbBKDsZbLqdusxXz1nfdUXmw2KXgYGNUgvpjx/vJUnQT7syNO1tBlC4CO3NgqR60rhEYdW2rAe7E8sEQTtx8erQ0AnUXtDQLv+yLlx/bj+Ryk4UkYv1YtBuH7EtGpPkhpT0wzYp8/g64ea7WZOleotee6TLX3Asj/EGI6CATEMMGD5V/d8ESsrXUsGErpr1pjSzqInOkDeBPFfZ8TTkNLdeafIoGJ5kG4UbY/cal3OwPKhMGtBH1T0L8RjJIkA+QZbXTXBInXsKPLW82rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfBGVdFSiRsESvqLSvNc4ESjtrWNOebaeM81LV42YIY=;
 b=kBKfhRKAMUbFnLCAAZl6vLkVoC0smpaxZG7v813Y+SuhX9L2N6acldKJIVarEcknXTT+dy5lWoZCFnd3FOhY2hkaZcQ2mgsJCNiSBnJx2gEUgqEXElndcSBu1Tb3ub0Q7mz8nypwqY/Qs6hNUhv+zEuEIYkPYnAg9VZke8geI+Q1pDKc12Jp6egT8KUwfbB/TBR0LWAPJpx9GqxGN6RyG/VI8vznWUuO/IryIvAKyE5PitQwxAxS6/5gRnacoaoBLJu6RQ2OqI/5MiidfoxZ9nyki1sHc2Lf17ZxD/KKd32WDz+KtYdFNnptez5v0WiZnCIQz7NVmlx8BHbYyVmhFQ==
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU2PR10MB7907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:491::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 13:14:58 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 13:14:58 +0000
From: "Schultschik, Sven" <sven.schultschik@siemens.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: AW: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Thread-Topic: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Thread-Index: AQHY45xPWaXKEQmUR0Ob3Ay49K84eK4Vi/qAgAAkdJA=
Date: Wed, 19 Oct 2022 13:14:58 +0000
Message-ID: 
 <PAXPR10MB5037C43EAD82531EC11A63E3902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <20221019092117.5291-2-sven.schultschik@siemens.com>
 <760608c4-0d6c-43f2-00c8-bc93de8cdeb4@siemens.com>
In-Reply-To: <760608c4-0d6c-43f2-00c8-bc93de8cdeb4@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-19T13:14:57Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=5f2ecd80-8e72-4651-8782-b48682362f9c;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5037:EE_|DU2PR10MB7907:EE_
x-ms-office365-filtering-correlation-id: 1aaf14e5-e705-41aa-c48d-08dab1d3ec4f
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AwFUcVM2aVMLAuEr+6VureA1jfkvuOJ+usWlxY6iAufr7wOEs9XmjI6FB47GKcTR3uqopZftRbg+0FMhmVoKuLrPGr6zrAoit5su6493vPEoEqhCoTQDyUPz7UrHUxSKMYzQrjnnZpGA3wOhTxBx3wZbngv8i0oPF9J4qiYpZTVL6DVuTFgmQTaE+TMDFV36oS8XnVcrO7CqU1fEEQj1zOzViXf4Gtk8b6pElPI83jnQ/F+YKhE2TuVihb6/8u2NSSh+gg/SRh4oI91yGFFDc6Mnq3encoMi6LlKcCKjIpa3ODVlISDDH6xYkp9hUk1YUEsPE9rwnHpPJE71aF67E3QU0AJxcNA16xWYjj7tMGUgEOM01B2WRy3CGNbBRuHV5gHzdpf/uCkkOe3tQGkqOSM+6ubcAC+4J3KCE0XS7JQgNykKIruFhzc18kqS2wvehYN+ZW5Sd7IjvzVZZnKVBttJtjRtOvKlBN/8yLGx44knRaf5ME95ETeGLzfgiQxiiqCDhcDmyc2aqdN1jIWcuBzc8AkHiCNeJSYF/I+DxV5oSl50CfuBYUyDoQCLuPtxMLT+qGpL4ijFQPFOTkNU3xqizPPGikSI9RBWnbwZ8vbdOYPA57FVYb7qjymHjEj+ZqJxnVjdjqugCuNStEpVAHFVFRU6OfFH6pLoJb9mV4WS34L2QQVVurwOTocvHEPj4xyNJc/rSJ2Eb2iuqB87dZFJSN673Vi7IwPph6PKOLZR1Oq9lPhVBDZ5BZaqyn8il4yzuYc2gNGlSoSr5wcBsQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(26005)(9686003)(6506007)(7696005)(41300700001)(86362001)(83380400001)(53546011)(110136005)(8676002)(66446008)(64756008)(66476007)(76116006)(66946007)(66556008)(8936002)(5660300002)(55016003)(52536014)(316002)(82960400001)(38100700002)(71200400001)(2906002)(33656002)(186003)(122000001)(478600001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ECFGtlcfjgjgGIXu2v1z268olrqJqs4QW80SVo0+DwgPu2ZAS+rHg73BhX?=
 =?iso-8859-1?Q?2kaHfSJnmWbA1vEpx/Sll/NVpJcrBE3WGb3zRxSYmYkeNU8Lea9x+TfixF?=
 =?iso-8859-1?Q?sfBUrtG/zkF4x/LM7+Ep5AqBsf3PYg0wROoza78j7qDcm8l28UDAhF2fco?=
 =?iso-8859-1?Q?wsWduY5sQRfwVZ5hMqOs4UZaAv7suHeIV2HXj6jXFyZGey2TEXJJY9WT9i?=
 =?iso-8859-1?Q?Gogkc96lkd9jeZjYxYT/C+IiQySRUuGlU2xPr8VkKzIVH9HXthYZ7VJMe5?=
 =?iso-8859-1?Q?LFoUoH0dLLrVi24SQT7mejN+Sc1NW5Ng1Wa314J7FpFh5ORvdf5KRU/BCw?=
 =?iso-8859-1?Q?pvNfhSQPTQJB3xMYkxKw4iJdtNHqVHUkN7+ahPHOgatpYZGoHidE3UeUXu?=
 =?iso-8859-1?Q?GLfnZrhDACIuUIwGQXOFJiJtNLo1d/77hELTCgd0wN36HiBMOwx6lUM53D?=
 =?iso-8859-1?Q?WsJwRAK78cBUKzIKnz3kOFb+oJrdloqHxHmBGIp24J3cYyf266MQZ0rktF?=
 =?iso-8859-1?Q?yvmjHIRqL6DnTgBCd5qlXrqb9KPCXv82HAaU1BFyjRa0Wc3bFvXDT2ACRW?=
 =?iso-8859-1?Q?ZP85K6FUGoLHOP9MaYNXF53RvmsroT447LduWP7tgFdIDGEkYenWM9VxIk?=
 =?iso-8859-1?Q?OTBhhTfC0yqkfb8o78xalCYbn+t4c72A78FuU3i0EQlA+Qw9Qq1h11gJxL?=
 =?iso-8859-1?Q?JMsH4QuM4XzCwop/K7OEEpcjWH4biq8azEiYzaBDViZCspCvVlCInQgdlT?=
 =?iso-8859-1?Q?BsAstcqkQYjKB8WmysuxaryVhmQLCNmE5Ha9+4FbFgbrd1dAjq0nQjTkHW?=
 =?iso-8859-1?Q?pB5HVmGsO83ziUG35IVsK4982vKtr4LX6i1RBlvDVWuT52o/F0zPnxTnPd?=
 =?iso-8859-1?Q?E5EuotdEyB1HBSzrN2xrlEp+CZsfhBpaTA68Prsxjs4FHGtnsQ1QOQhK0w?=
 =?iso-8859-1?Q?jsDLqPZwpfJdm2TEcQG5GpWNgUFwFTj7tu1R/mrgBBG6j8N/+rjWsFtX56?=
 =?iso-8859-1?Q?PiJ7KrVMtn5CLGjLDqi1FAe5fjtxL6xzm6eGC2viRsj2ajZaaLPcFvbp8C?=
 =?iso-8859-1?Q?fk+ZiqcRuWhLhp4DIpFRO/K/APxydm2gKnPBFArSAeHhWeVkLN/WeEGUzH?=
 =?iso-8859-1?Q?eSyCx8Vw/zluQEU+XNWWGl2fB+33CJzwmLTDZE8EpyqSt/Yc76hF6qSki/?=
 =?iso-8859-1?Q?QUZbRg3DpiFb/UcBSWXO9DH3iHi28dvkOb7y+fZE+vZ7IBafM4miaRbwHd?=
 =?iso-8859-1?Q?CrIlLZkrshxfZKPJiER4QGN6mQ6E0MBCuk9LUmFK5fe392HaY5jmisw6RY?=
 =?iso-8859-1?Q?ix8egKwpDPwyM1j0pCjrFTRxiaNAeRz8PoZYHDbmXCyo/ouP1crhcAPndP?=
 =?iso-8859-1?Q?sHdkcyQMXhwW1vRl/EQJRoDz51V8TdAvjL7QXCin8kqhbSNrUv8Kh9Kj0R?=
 =?iso-8859-1?Q?QYTNQK3GC19yTmuwAdmzvViVmg/8mfTKDLJuBG39lO6HIfwPrT+hw6fsJg?=
 =?iso-8859-1?Q?Fl0HaRG9zSTbUUdGamtW6AnOfMFy2Y7IPv4aCQnmziHsvC33Onlx+XJ3m+?=
 =?iso-8859-1?Q?7Zkeg+wR5hPei0ZoGkkseoAkMpbfVPPSQWy5dUT5AkEOCMA3I0eKKakua2?=
 =?iso-8859-1?Q?BA4nCAHCS4Z1XG2kP9gp9NE4tp162qViRMvN1PEa3Zrfg4Kfr+cpZbqw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaf14e5-e705-41aa-c48d-08dab1d3ec4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 13:14:58.6744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPcDRcb0zdRGVsYMwuD/8smI+NOK2ZAE0Q7h7UcMUoIoq3jrteirGRmptlKZdGL/TdUtMPqx+RhC6HSLkRPnYSDQhQ/nHPzPq3DhfuZcnTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7907
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 13:15:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9787



> -----Urspr=FCngliche Nachricht-----
> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Gesendet: Mittwoch, 19. Oktober 2022 12:58
> An: Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>; c=
ip-
> dev@lists.cip-project.org
> Betreff: Re: [isar-cip-core][PATCH 2/7] add recipe for for edk2
>
> On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
> > From: Sven Schultschik <sven.schultschik@siemens.com>
> > +MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
> > +LICENSE =3D "BSD-2-Clause-Patent"
> > +
> > +inherit dpkg
> > +
> > +SRC_URI =3D
> "gitsm://github.com/tianocore/edk2.git;branch=3Dmaster;protocol=3Dhttps;d=
estsuff
> ix=3Dgit/edk2;rev=3Dedk2-stable${PV} \
> > +
> > +git://github.com/tianocore/edk2-platforms.git;protocol=3Dhttps;destsuf=
f
> > +ix=3Dgit/edk2-platforms;rev=3D3b896d1a325686de3942723c42f286090453e37a=
 \
>
> - gitsm (see patch 1/7)

EDK2 really uses submodules which need to be pulled

> - please factor out revisions into separate variables
>
> Or can we also address the revisions via release tags? The recipe carries=
 a
> release version number in the end...
>
> > +            file://debian \
> > +            "
> > +S =3D "${WORKDIR}/git"
> > +
> > +BUILD_DEPENDS   +=3D ""
> > +
> > +TEMPLATE_FILES =3D "debian/changelog.tmpl debian/control.tmpl
> debian/rules.tmpl"
> > +TEMPLATE_VARS +=3D "BUILD_DEPENDS S"
> > +
> > +ISAR_CROSS_COMPILE =3D "0"
>
> Why?

EDK2 has it's own build parameter for the target architecture, which activa=
tes cross compile
Within EDK2 build which breaks if isar cross is activated.
build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(shell=
 nproc)

You suggest to turn it off and try if isar cross compile could be enough?

Sven

