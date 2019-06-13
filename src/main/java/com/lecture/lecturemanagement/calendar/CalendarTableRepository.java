package com.lecture.lecturemanagement.calendar;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.List;

public interface CalendarTableRepository extends JpaRepository<CalendarTable,Long> {

    //ID로 모든 TimeTable 조회
    @Query("select ct from CalendarTable ct where ct.uid=:uid")
    List<CalendarTable> findAllByUid(@Param("uid") String uid);

    //table_id로 일정 삭제
    @Transactional
    void deleteCalendarTableById(long id);

    //uid 와 subject로 시간표 삭제
    @Transactional
    @Modifying
    @Query("delete from CalendarTable ct where ct.uid=:uid and ct.title=:subject")
    void deleteCalendarTableByUidAndSubject(@Param("uid") String uid,@Param("subject") String subject);

}
