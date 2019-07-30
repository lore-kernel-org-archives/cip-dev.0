From: pavel@denx.de (Pavel Machek)
Date: Tue, 30 Jul 2019 11:51:40 +0200
Subject: [cip-dev] phy-rcar-gen3-usb2: wrong parsing of role in role_store?
Message-ID: <20190730095140.GA29609@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

Code does strcmps, but does not actually check count. So AFAICT
writing "host-I-don't-want-I-need-peripheral" into the file will
succeed and turn it into host mode.

Also data beyond count in buf are going to be accessed.

Best regards,
								Pavel

static ssize_t role_store(struct device *dev, struct device_attribute *attr,
                          const char *buf, size_t count)
{
        struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
        bool is_b_device;
        enum phy_mode cur_mode, new_mode;

        if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
                return -EIO;

        /* FIXME, this is wrong */
        if (!strncmp(buf, "host", strlen("host")))
                new_mode = PHY_MODE_USB_HOST;
        else if (!strncmp(buf, "peripheral", strlen("peripheral")))
                new_mode = PHY_MODE_USB_DEVICE;
        else
                return -EINVAL;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190730/70b35f65/attachment.sig>
