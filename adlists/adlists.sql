CREATE TEMP TABLE i(txt);
.separator ~
.import /home/pi/adlists/adlists.list i
INSERT OR IGNORE INTO adlist (address) SELECT txt FROM i;
UPDATE adlist set comment='firebog.net' where comment is null;
DROP TABLE i;
