from django.db import models

class Event(models.Model):
  name = models.CharField()
  desc = models.CharField(blank=False)
  id = models.CharField(blank=False)
  creator_id = models.CharField(blank=False)
  promo_video_url = models.CharField(blank=False)
  created_at = models.DateTimeField()
  event_date = models.DateTimeField()
  no_of_tickets_category = models.IntegerField()
  no_of_tickets = models.IntegerField()
  is_private = models.BooleanField()
  def __str__(self):
    return '%s' % (self.name)