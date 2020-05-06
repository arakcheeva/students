package com.company.servlet.entity;

import lombok.Data;
import javax.persistence.*;

@Entity
@Table(name = "pb_user_session")
@Data
public class UserSession {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "userSessionSeq", sequenceName = "seq_user_session", initialValue = 1000, allocationSize = 1000)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(nullable = false)
    private String password;
}